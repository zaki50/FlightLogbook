import 'package:flightlogbook/bloc/add_flight/add_flight_event.dart';
import 'package:flightlogbook/bloc/add_flight/add_flight_state.dart';
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
    yield AddFlightAdding();
    try {
      final addedEntry = await _repository.addFlight(event.year, event.entry);
      yield AddFlightSuccess(addedEntry);
    } catch (e) {
      debugPrint(e.toString());

      yield AddFlightFailure();
    }
  }
}
