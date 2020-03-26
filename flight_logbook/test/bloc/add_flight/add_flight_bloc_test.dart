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
    final newEntry = FlightEntry.forNew(data: const {
      FlightEntry.FIELD_DEPARTURE_DATE: '1/1',
      FlightEntry.FIELD_DEPARTURE_TIME: '1200',
      FlightEntry.FIELD_DEPARTURE_TIMEZONE: '+0900',
    });

    final Map<String, dynamic> dataCopy = Map.from(newEntry.data);
    dataCopy[FlightEntry.FIELD_ORDER] = 1577847600;

    when(repository.addFlight(2020, dataCopy))
        .thenAnswer((_) => Future.value(FlightEntry(id: 'a', data: dataCopy)));
    final bloc = AddFlightBloc(repository: repository);
    expectLater(
        bloc,
        emitsInOrder([
          AddFlightInitial(),
          AddFlightAdding(2020, newEntry),
          AddFlightSuccess(2020, FlightEntry(id: 'a', data: dataCopy)),
        ]));
    bloc.add(AddFlight(2020, newEntry));
  });

  test('test add flight failure', () {
    final repository = _MockFlightsRepository();
    final newEntry = FlightEntry.forNew(data: const {
      FlightEntry.FIELD_DEPARTURE_DATE: '1/1',
      FlightEntry.FIELD_DEPARTURE_TIME: '1200',
      FlightEntry.FIELD_DEPARTURE_TIMEZONE: '+0900',
      // 本当はorderも渡されてくるが、テスト的には問題ないので省略
    });

    final Map<String, dynamic> dataCopy = Map.from(newEntry.data);
    dataCopy[FlightEntry.FIELD_ORDER] = 1577847600;

    when(repository.addFlight(2020, dataCopy)).thenThrow(Exception());
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

  test('test add failure for missing mandatory field (date)', () {
    final repository = _MockFlightsRepository();
    final newEntry = FlightEntry.forNew(data: const {
      FlightEntry.FIELD_DEPARTURE_TIME: '1200',
      FlightEntry.FIELD_DEPARTURE_TIMEZONE: '+0900',
      // 本当はorderも渡されてくるが、テスト的には問題ないので省略
    });
    when(repository.addFlight(2020, newEntry.data)).thenThrow(Exception());
    final bloc = AddFlightBloc(repository: repository);
    expectLater(
        bloc,
        emitsInOrder([
          AddFlightInitial(),
          AddFlightFailure(
              2020,
              newEntry,
              MissingMandatoryPropertyException(
                  FlightEntry.FIELD_DEPARTURE_DATE)),
        ]));
    bloc.add(AddFlight(2020, newEntry));
  });

  test('test add failure for missing mandatory field (time)', () {
    final repository = _MockFlightsRepository();
    final newEntry = FlightEntry.forNew(data: const {
      FlightEntry.FIELD_DEPARTURE_DATE: '1/1',
      FlightEntry.FIELD_DEPARTURE_TIMEZONE: '+0900',
      // 本当はorderも渡されてくるが、テスト的には問題ないので省略
    });
    when(repository.addFlight(2020, newEntry.data)).thenThrow(Exception());
    final bloc = AddFlightBloc(repository: repository);
    expectLater(
        bloc,
        emitsInOrder([
          AddFlightInitial(),
          AddFlightFailure(
              2020,
              newEntry,
              MissingMandatoryPropertyException(
                  FlightEntry.FIELD_DEPARTURE_TIME)),
        ]));
    bloc.add(AddFlight(2020, newEntry));
  });

  test('test add failure for missing mandatory field (timezone)', () {
    final repository = _MockFlightsRepository();
    final newEntry = FlightEntry.forNew(data: const {
      FlightEntry.FIELD_DEPARTURE_DATE: '1/1',
      FlightEntry.FIELD_DEPARTURE_TIME: '1200',
      // 本当はorderも渡されてくるが、テスト的には問題ないので省略
    });
    when(repository.addFlight(2020, newEntry.data)).thenThrow(Exception());
    final bloc = AddFlightBloc(repository: repository);
    expectLater(
        bloc,
        emitsInOrder([
          AddFlightInitial(),
          AddFlightFailure(
              2020,
              newEntry,
              MissingMandatoryPropertyException(
                  FlightEntry.FIELD_DEPARTURE_TIMEZONE)),
        ]));
    bloc.add(AddFlight(2020, newEntry));
  });

  test('test toOrder', () {
    expect(1601523240, AddFlightBloc.toOrder(2020, '10/1', '1234', '+0900'));

    // +0900の1234は+0800の1134
    expect(AddFlightBloc.toOrder(2020, '10/1', '1234', '+0900'),
        AddFlightBloc.toOrder(2020, '10/1', '1134', '+0800'));

    // year differs
    expect(AddFlightBloc.toOrder(2020, '10/1', '1234', '+0900'),
        isNot(AddFlightBloc.toOrder(2021, '10/1', '1234', '+0900')));
    // month differs
    expect(AddFlightBloc.toOrder(2020, '10/1', '1234', '+0900'),
        isNot(AddFlightBloc.toOrder(2020, '11/1', '1234', '+0900')));
    // day differs
    expect(AddFlightBloc.toOrder(2020, '10/1', '1234', '+0900'),
        isNot(AddFlightBloc.toOrder(2020, '10/2', '1234', '+0900')));
    // hour differs
    expect(AddFlightBloc.toOrder(2020, '10/1', '1234', '+0900'),
        isNot(AddFlightBloc.toOrder(2020, '10/1', '1334', '+0900')));
    // minute differs
    expect(AddFlightBloc.toOrder(2020, '10/1', '1234', '+0900'),
        isNot(AddFlightBloc.toOrder(2020, '10/1', '1235', '+0900')));
    // timezone sign differs
    expect(AddFlightBloc.toOrder(2020, '10/1', '1234', '+0900'),
        isNot(AddFlightBloc.toOrder(2020, '10/1', '1234', '-0900')));
    // timezone hour differs
    expect(AddFlightBloc.toOrder(2020, '10/1', '1234', '+0900'),
        isNot(AddFlightBloc.toOrder(2020, '10/1', '1234', '+1000')));
    // timezone minute differs
    expect(AddFlightBloc.toOrder(2020, '10/1', '1234', '+0900'),
        isNot(AddFlightBloc.toOrder(2020, '10/1', '1234', '+0901')));

    expect(AddFlightBloc.toOrder(2020, '10/1', '1234', '+0900'),
        AddFlightBloc.toOrder(2020, '10/1', '1234', '-0900') - 18 * 3600);
  });
}
