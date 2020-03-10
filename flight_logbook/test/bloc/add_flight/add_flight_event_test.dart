import 'package:flightlogbook/bloc/add_flight/add_flight_event.dart';
import 'package:flightlogbook/repository/flights/flight_entry.dart';
import 'package:test/test.dart';

void main() {
  test('test of == for AddFlight', () {
    expect(
      AddFlight(2020, FlightEntry(id: 'a', data: const {})),
      equals(AddFlight(2020, FlightEntry(id: 'a', data: const {}))),
    );
  });

  test('test of != for AddFlight', () {
    expect(
      AddFlight(2019, FlightEntry(id: 'a', data: const {})),
      isNot(equals(AddFlight(2020, FlightEntry(id: 'a', data: const {})))),
    );
    expect(
      AddFlight(2020, FlightEntry(id: 'a', data: const {})),
      isNot(equals(AddFlight(2020, FlightEntry(id: 'b', data: const {})))),
    );
    expect(
      AddFlight(2019, FlightEntry(id: 'a', data: const {})),
      isNot(equals(AddFlight(2020, FlightEntry(id: 'b', data: const {})))),
    );
  });
}
