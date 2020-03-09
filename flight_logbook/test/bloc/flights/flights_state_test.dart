import 'package:flightlogbook/bloc/flights/flight_entry.dart';
import 'package:flightlogbook/bloc/flights/flights_state.dart';
import 'package:test/test.dart';

void main() {
  testFor_equals();
}

// ignore: non_constant_identifier_names
void testFor_equals() {
  test('test of FlightsInitial ==', () {
    expect(
      FlightsInitial(),
      equals(FlightsInitial()),
    );
  });

  test('test of FlightsLoading ==', () {
    expect(
      FlightsLoading(2020),
      equals(FlightsLoading(2020)),
    );
  });

  test('test of FlightsLoading !=', () {
    expect(
      FlightsLoading(2019),
      isNot(equals(FlightsLoading(2020))),
    );
  });

  test('test of FlightsSuccess ==', () {
    expect(
      FlightsSuccess(2020, const []),
      equals(FlightsSuccess(2020, const [])),
    );
  });

  test('test of FlightsSuccess !=', () {
    expect(
      FlightsSuccess(2019, const []),
      equals(FlightsSuccess(2020, const [])),
    );
    expect(
      FlightsSuccess(2020, [FlightEntry(id: 'a', data: const {})]),
      equals(FlightsSuccess(2020, [FlightEntry(id: 'b', data: const {})])),
    );
    expect(
      FlightsSuccess(2019, [FlightEntry(id: 'a', data: const {})]),
      equals(FlightsSuccess(2020, [FlightEntry(id: 'a', data: const {})])),
    );
  });

  test('test of FlightsFailure ==', () {
    expect(
      FlightsFailure(2020),
      equals(FlightsFailure(2020)),
    );
  });

  test('test of FlightsFailure !=', () {
    expect(
      FlightsFailure(2019),
      equals(FlightsFailure(2020)),
    );
  });

  test('test of RemovingFlight ==', () {
    expect(
      RemovingFlight(2020, 'a'),
      equals(RemovingFlight(2020, 'a')),
    );
  });

  test('test of RemovingFlight !=', () {
    expect(
      RemovingFlight(2019, 'a'),
      equals(RemovingFlight(2020, 'a')),
    );
    expect(
      RemovingFlight(2020, 'a'),
      equals(RemovingFlight(2020, 'b')),
    );
    expect(
      RemovingFlight(2019, 'a'),
      equals(RemovingFlight(2020, 'b')),
    );
  });

  test('test of RemoveFlightSuccess ==', () {
    expect(
      RemoveFlightSuccess(2020, 'a'),
      equals(RemoveFlightSuccess(2020, 'a')),
    );
  });

  test('test of RemoveFlightSuccess !=', () {
    expect(
      RemoveFlightSuccess(2019, 'a'),
      equals(RemoveFlightSuccess(2020, 'a')),
    );
    expect(
      RemoveFlightSuccess(2020, 'a'),
      equals(RemoveFlightSuccess(2020, 'b')),
    );
    expect(
      RemoveFlightSuccess(2019, 'a'),
      equals(RemoveFlightSuccess(2020, 'b')),
    );
  });

  test('test of RemoveFlightFailure ==', () {
    expect(
      RemoveFlightFailure(2020, 'a'),
      equals(RemoveFlightFailure(2020, 'a')),
    );
  });

  test('test of RemoveFlightFailure !=', () {
    expect(
      RemoveFlightFailure(2019, 'a'),
      equals(RemoveFlightFailure(2020, 'a')),
    );
    expect(
      RemoveFlightFailure(2020, 'a'),
      equals(RemoveFlightFailure(2020, 'b')),
    );
    expect(
      RemoveFlightFailure(2019, 'a'),
      equals(RemoveFlightFailure(2020, 'b')),
    );
  });

  test('test of != for differnt types', () {
    expect(
      FlightsInitial(),
      isNot(equals(FlightsLoading(2020))),
    );
    expect(
      FlightsInitial(),
      isNot(equals(FlightsSuccess(2020, const []))),
    );
    expect(
      FlightsInitial(),
      isNot(equals(FlightsFailure(2020))),
    );
    expect(
      FlightsInitial(),
      isNot(equals(RemovingFlight(2020, 'a'))),
    );
    expect(
      FlightsInitial(),
      isNot(equals(RemoveFlightSuccess(2020, 'a'))),
    );
    expect(
      FlightsInitial(),
      isNot(equals(RemoveFlightFailure(2020, 'a'))),
    );

    expect(
      FlightsLoading(2020),
      isNot(equals(FlightsInitial())),
    );
    expect(
      FlightsLoading(2020),
      isNot(equals(FlightsSuccess(2020, const []))),
    );
    expect(
      FlightsLoading(2020),
      isNot(equals(FlightsFailure(2020))),
    );
    expect(
      FlightsLoading(2020),
      isNot(equals(RemovingFlight(2020, 'a'))),
    );
    expect(
      FlightsLoading(2020),
      isNot(equals(RemoveFlightSuccess(2020, 'a'))),
    );
    expect(
      FlightsLoading(2020),
      isNot(equals(RemoveFlightFailure(2020, 'a'))),
    );

    expect(
      FlightsSuccess(2020, const []),
      isNot(equals(FlightsInitial())),
    );
    expect(
      FlightsSuccess(2020, const []),
      isNot(equals(FlightsLoading(2020))),
    );
    expect(
      FlightsSuccess(2020, const []),
      isNot(equals(FlightsFailure(2020))),
    );
    expect(
      FlightsSuccess(2020, const []),
      isNot(equals(RemovingFlight(2020, 'a'))),
    );
    expect(
      FlightsSuccess(2020, const []),
      isNot(equals(RemoveFlightSuccess(2020, 'a'))),
    );
    expect(
      FlightsSuccess(2020, const []),
      isNot(equals(RemoveFlightFailure(2020, 'a'))),
    );

    expect(
      FlightsFailure(2020),
      isNot(equals(FlightsInitial())),
    );
    expect(
      FlightsFailure(2020),
      isNot(equals(FlightsLoading(2020))),
    );
    expect(
      FlightsFailure(2020),
      isNot(equals(FlightsSuccess(2020, const []))),
    );
    expect(
      FlightsFailure(2020),
      isNot(equals(RemovingFlight(2020, 'a'))),
    );
    expect(
      FlightsFailure(2020),
      isNot(equals(RemoveFlightSuccess(2020, 'a'))),
    );
    expect(
      FlightsFailure(2020),
      isNot(equals(RemoveFlightFailure(2020, 'a'))),
    );

    expect(
      RemovingFlight(2020, 'a'),
      isNot(equals(FlightsInitial())),
    );
    expect(
      RemovingFlight(2020, 'a'),
      isNot(equals(FlightsLoading(2020))),
    );
    expect(
      RemovingFlight(2020, 'a'),
      isNot(equals(FlightsSuccess(2020, const []))),
    );
    expect(
      RemovingFlight(2020, 'a'),
      isNot(equals(FlightsFailure(2020))),
    );
    expect(
      RemovingFlight(2020, 'a'),
      isNot(equals(RemovingFlight(2020, 'a'))),
    );
    expect(
      RemovingFlight(2020, 'a'),
      isNot(equals(RemoveFlightSuccess(2020, 'a'))),
    );
    expect(
      RemovingFlight(2020, 'a'),
      isNot(equals(RemoveFlightFailure(2020, 'a'))),
    );

    expect(
      RemoveFlightSuccess(2020, 'a'),
      isNot(equals(FlightsInitial())),
    );
    expect(
      RemoveFlightSuccess(2020, 'a'),
      isNot(equals(FlightsLoading(2020))),
    );
    expect(
      RemoveFlightSuccess(2020, 'a'),
      isNot(equals(FlightsSuccess(2020, const []))),
    );
    expect(
      RemoveFlightSuccess(2020, 'a'),
      isNot(equals(FlightsFailure(2020))),
    );
    expect(
      RemoveFlightSuccess(2020, 'a'),
      isNot(equals(RemovingFlight(2020, 'a'))),
    );
    expect(
      RemoveFlightSuccess(2020, 'a'),
      isNot(equals(RemoveFlightFailure(2020, 'a'))),
    );

    expect(
      RemoveFlightFailure(2020, 'a'),
      isNot(equals(FlightsInitial())),
    );
    expect(
      RemoveFlightFailure(2020, 'a'),
      isNot(equals(FlightsLoading(2020))),
    );
    expect(
      RemoveFlightFailure(2020, 'a'),
      isNot(equals(FlightsSuccess(2020, const []))),
    );
    expect(
      RemoveFlightFailure(2020, 'a'),
      isNot(equals(FlightsFailure(2020))),
    );
    expect(
      RemoveFlightFailure(2020, 'a'),
      isNot(equals(RemovingFlight(2020, 'a'))),
    );
    expect(
      RemoveFlightFailure(2020, 'a'),
      isNot(equals(RemoveFlightSuccess(2020, 'a'))),
    );
    expect(
      RemoveFlightFailure(2020, 'a'),
      isNot(equals(RemoveFlightFailure(2020, 'a'))),
    );
  });
}
