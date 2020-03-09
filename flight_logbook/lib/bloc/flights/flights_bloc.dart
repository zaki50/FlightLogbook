import 'package:flightlogbook/bloc/flights/flight_entry.dart';
import 'package:flightlogbook/bloc/flights/flights_event.dart';
import 'package:flightlogbook/bloc/flights/flights_repository.dart';
import 'package:flightlogbook/bloc/flights/flights_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FlightsBloc extends Bloc<FlightsEvent, FlightsState> {
  final FlightsRepository _repository;

  FlightsBloc({
    @required FlightsRepository repository,
  })  : assert(repository != null),
        _repository = repository;

  @override
  FlightsState get initialState => FlightsInitial();

  @override
  Stream<FlightsState> mapEventToState(FlightsEvent event) async* {
    if (event is LoadAllFlights) {
      yield* _mapLoadAllFlightsToState(event);
    } else if (event is RemoveFlight) {
      yield* _mapRemoveFlightToState(event);
    }
  }

  Stream<FlightsState> _mapLoadAllFlightsToState(LoadAllFlights event) async* {
    yield FlightsLoading(event.year);
    try {
      final List<FlightEntry> allFlights =
          await _repository.getAllFlights(event.year);
      yield FlightsSuccess(event.year, allFlights);
    } catch (_) {
      yield FlightsFailure(event.year);
    }
  }

  Stream<FlightsState> _mapRemoveFlightToState(RemoveFlight event) async* {
    yield RemovingFlight(event.year, event.flightId);
    try {
      await _repository.removeFlight(event.year, event.flightId);
      yield RemoveFlightSuccess(event.year, event.flightId);
    } catch (_) {
      yield RemoveFlightFailure(event.year, event.flightId);
    }
  }
}
