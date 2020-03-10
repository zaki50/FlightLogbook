import 'package:flightlogbook/bloc/add_flight/add_flight_bloc.dart';
import 'package:flightlogbook/bloc/add_flight/add_flight_event.dart';
import 'package:flightlogbook/bloc/add_flight/add_flight_state.dart';
import 'package:flightlogbook/repository/flights/flight_entry.dart';
import 'package:flightlogbook/repository/flights/flights_repository.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

class _MockFlightsRepository extends Mock implements FlightsRepository {}

void main() {
  test('test initial state', () {
    final repository = _MockFlightsRepository();
    final bloc = AddFlightBloc(repository: repository);
    expectLater(bloc, emitsInOrder([AddFlightInitial()]));
    expectLater(
        bloc,
        neverEmits(
            AddFlightAdding(2020, FlightEntry(id: 'a', data: const {}))));
    expectLater(
        bloc,
        neverEmits(
            AddFlightSuccess(2020, FlightEntry(id: 'a', data: const {}))));
    expectLater(
        bloc,
        neverEmits(
            AddFlightFailure(2020, FlightEntry(id: 'a', data: const {}))));
    bloc.close();
  });

  test('test add flight success', () {
    final repository = _MockFlightsRepository();
    final newEntry = FlightEntry.forNew(data: const {});
    when(repository.addFlight(2020, newEntry))
        .thenAnswer((_) => Future.value(FlightEntry(id: 'a', data: const {})));
    final bloc = AddFlightBloc(repository: repository);
    expectLater(
        bloc,
        emitsInOrder([
          AddFlightInitial(),
          AddFlightAdding(2020, newEntry),
          AddFlightSuccess(2020, FlightEntry(id: 'a', data: const {})),
        ]));
    bloc.add(AddFlight(2020, newEntry));
  });

  test('test add flight failure', () {
    final repository = _MockFlightsRepository();
    final newEntry = FlightEntry.forNew(data: const {});
    when(repository.addFlight(2020, newEntry)).thenThrow(Exception());
    final bloc = AddFlightBloc(repository: repository);
    expectLater(
        bloc,
        emitsInOrder([
          AddFlightInitial(),
          AddFlightAdding(2020, newEntry),
          AddFlightFailure(2020, newEntry),
        ]));
    bloc.add(AddFlight(2020, newEntry));
  });
}
