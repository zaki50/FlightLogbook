import 'package:flightlogbook/bloc/add_flight/add_flight_event.dart';
import 'package:flightlogbook/bloc/add_flight/add_flight_state.dart';
import 'package:flightlogbook/repository/flights/flight_entry.dart';
import 'package:flightlogbook/repository/flights/flights_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddFlightBloc extends Bloc<AddFlightEvent, AddFlightState> {
  final FlightsRepository _repository;

  AddFlightBloc({
    @required FlightsRepository repository,
  })  : assert(repository != null),
        _repository = repository;

  @override
  AddFlightState get initialState => AddFlightInitial();

  @override
  Stream<AddFlightState> mapEventToState(AddFlightEvent event) async* {
    if (event is AddFlight) {
      yield* _mapAddFlightToState(event);
    }
  }

  Stream<AddFlightState> _mapAddFlightToState(AddFlight event) async* {
    final Map<String, dynamic> entryData = Map.from(event.entry.data);

    final date = entryData[FlightEntry.FIELD_DEPARTURE_DATE];
    if (date == null) {
      yield AddFlightFailure(event.year, event.entry,
          MissingMandatoryPropertyException(FlightEntry.FIELD_DEPARTURE_DATE));
      return;
    }
    final time = entryData[FlightEntry.FIELD_DEPARTURE_TIME];
    if (time == null) {
      yield AddFlightFailure(event.year, event.entry,
          MissingMandatoryPropertyException(FlightEntry.FIELD_DEPARTURE_TIME));
      return;
    }
    final timezone = entryData[FlightEntry.FIELD_DEPARTURE_TIMEZONE];
    if (timezone == null) {
      yield AddFlightFailure(
          event.year,
          event.entry,
          MissingMandatoryPropertyException(
              FlightEntry.FIELD_DEPARTURE_TIMEZONE));
      return;
    }

    try {
      final int order = toOrder(event.year, date, time, timezone);
      entryData[FlightEntry.FIELD_ORDER] = order;
    } on InvalidPropertyValueFormatException catch (e) {
      yield AddFlightFailure(event.year, event.entry, e);
      return;
    }

    yield AddFlightAdding(event.year, event.entry);
    try {
      final addedEntry = await _repository.addFlight(event.year, entryData);
      yield AddFlightSuccess(event.year, addedEntry);
    } catch (e) {
      yield AddFlightFailure(event.year, event.entry);
    }
  }

  static final RegExp DATE_REGEXP = RegExp(r'([0-9]{1,2})/([0-9]{1,2})');
  static final RegExp TIME_REGEXP = RegExp(r'([0-9]{2}):?([0-9]{2})');
  static final RegExp TIMEZONE_REGEXP = RegExp(r'([-+])([0-9]{2})([0-9]{2})');

  static int toOrder(int year, String date, String time, String timezone) {
    final dateMatch = DATE_REGEXP.firstMatch(date);
    if (dateMatch == null) {
      throw InvalidPropertyValueFormatException(
          FlightEntry.FIELD_DEPARTURE_DATE);
    }
    final timeMatch = TIME_REGEXP.firstMatch(time);
    if (timeMatch == null) {
      throw InvalidPropertyValueFormatException(
          FlightEntry.FIELD_DEPARTURE_TIME);
    }
    final timezoneMatch = TIMEZONE_REGEXP.firstMatch(timezone);
    if (timezoneMatch == null) {
      throw InvalidPropertyValueFormatException(
          FlightEntry.FIELD_DEPARTURE_TIMEZONE);
    }

    final String monthStr = dateMatch.group(1);
    final String dayStr = dateMatch.group(2);
    final String hourStr = timeMatch.group(1);
    final String minuteStr = timeMatch.group(2);
    final String timezoneSignStr = timezoneMatch.group(1);
    final String timezoneHourStr = timezoneMatch.group(2);
    final String timezoneMinuteStr = timezoneMatch.group(3);

    final int month = int.parse(monthStr);
    final int day = int.parse(dayStr);
    final int hour = int.parse(hourStr);
    final int minute = int.parse(minuteStr);

    final int timezoneHour = int.parse(timezoneHourStr);
    final int timezoneMinute = int.parse(timezoneMinuteStr);

    final int secondsSinceEpoch =
        DateTime.utc(year, month, day, hour, minute).millisecondsSinceEpoch ~/
            1000;
    final int offset = (timezoneSignStr == '+' ? -1 : 1) * timezoneHour * 3600 +
        timezoneMinute * 60;
    return secondsSinceEpoch + offset;
  }
}
