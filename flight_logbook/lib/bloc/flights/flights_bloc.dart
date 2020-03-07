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
      yield* _mapLoadAllFlightsToState();
    }
  }

  Stream<FlightsState> _mapLoadAllFlightsToState() async* {
    yield FlightsLoading();
    try {
      final List<FlightEntry> allFlights = await _repository.getAllFlights();
      yield FlightsSuccess(allFlights);
    } catch (_) {
      yield FlightsFailure();
    }
  }
}
