import 'package:flightlogbook/bloc/flights/flights_bloc.dart';
import 'package:flightlogbook/bloc/flights/flights_event.dart';
import 'package:flightlogbook/bloc/flights/flights_state.dart';
import 'package:flightlogbook/repository/flights/flight_entry.dart';
import 'package:flightlogbook/repository/flights/flights_repository.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

void main() {
  testFor_FlightsBloc();
}

class MockFlightsRepository extends Mock implements FlightsRepository {}

void testFor_FlightsBloc() {
  test('test initial state', () {
    final FlightsRepository mockFlightsRepository = MockFlightsRepository();
    final bloc = FlightsBloc(repository: mockFlightsRepository);
    expectLater(bloc, emitsInOrder([FlightsInitial()]));
    expectLater(bloc, neverEmits(FlightsLoading(2020)));
    expectLater(bloc, neverEmits(FlightsSuccess(2020, const [])));
    expectLater(bloc, neverEmits(FlightsFailure(2020)));
    expectLater(bloc, neverEmits(RemovingFlight(2020, 'a')));
    expectLater(bloc, neverEmits(RemoveFlightSuccess(2020, 'a')));
    expectLater(bloc, neverEmits(RemoveFlightFailure(2020, 'a')));
    bloc.close();
  });

  test('test loading flights success', () {
    final FlightsRepository mockFlightsRepository = MockFlightsRepository();
    when(mockFlightsRepository.getAllFlights(2020)).thenAnswer((_) {
      return Future.value([
        FlightEntry(id: 'a', data: const {'aa': 'bb'})
      ]);
    });
    final bloc = FlightsBloc(repository: mockFlightsRepository);
    expectLater(
        bloc,
        emitsInOrder([
          FlightsInitial(),
          FlightsLoading(2020),
          FlightsSuccess(2020, [
            FlightEntry(id: 'a', data: const {'aa': 'bb'})
          ]),
        ]));
    bloc.add(LoadAllFlights(2020));
  });

  test('test loading flights failure', () {
    final FlightsRepository mockFlightsRepository = MockFlightsRepository();
    when(mockFlightsRepository.getAllFlights(2020)).thenThrow(Exception());
    final bloc = FlightsBloc(repository: mockFlightsRepository);
    expectLater(
        bloc,
        emitsInOrder([
          FlightsInitial(),
          FlightsLoading(2020),
          FlightsFailure(2020),
        ]));
    bloc.add(LoadAllFlights(2020));
  });

  //  FlightsInitial
//  FlightsLoading
//  FlightsSuccess
//  FlightsFailure
//  RemovingFlight
//  RemoveFlightSuccess
//  RemoveFlightFailure

  test('test remove flight success', () {
    final FlightsRepository mockFlightsRepository = MockFlightsRepository();
    when(mockFlightsRepository.removeFlight(2020, 'a')).thenAnswer((_) {
      return;
    });
    final bloc = FlightsBloc(repository: mockFlightsRepository);
    expectLater(
        bloc,
        emitsInOrder([
          FlightsInitial(),
          RemovingFlight(2020, 'a'),
          RemoveFlightSuccess(2020, 'a'),
        ]));
    bloc.add(RemoveFlight(2020, 'a'));
  });

  test('test remove flight failure', () {
    final FlightsRepository mockFlightsRepository = MockFlightsRepository();
    when(mockFlightsRepository.removeFlight(2020, 'a')).thenThrow(Exception());
    final bloc = FlightsBloc(repository: mockFlightsRepository);
    expectLater(
        bloc,
        emitsInOrder([
          FlightsInitial(),
          RemovingFlight(2020, 'a'),
          RemoveFlightFailure(2020, 'a'),
        ]));
    bloc.add(RemoveFlight(2020, 'a'));
  });
}
