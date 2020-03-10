import 'package:flightlogbook/bloc/add_flight/add_flight_state.dart';
import 'package:flightlogbook/repository/flights/flight_entry.dart';
import 'package:test/test.dart';

void main() {
  test('test of AddFlightInitial ==', () {
    expect(
      AddFlightInitial(),
      equals(AddFlightInitial()),
    );
  });

  test('test of AddFlightAdding ==', () {
    expect(
      AddFlightAdding(2020, FlightEntry(id: 'a', data: const {})),
      equals(AddFlightAdding(2020, FlightEntry(id: 'a', data: const {}))),
    );
  });

  test('test of AddFlightSuccess ==', () {
    expect(
      AddFlightSuccess(2020, FlightEntry(id: 'a', data: const {})),
      equals(AddFlightSuccess(2020, FlightEntry(id: 'a', data: const {}))),
    );
  });

  test('test of AddFlightSuccess !=', () {
    expect(
      AddFlightSuccess(2019, FlightEntry(id: 'a', data: const {})),
      isNot(
          equals(AddFlightSuccess(2020, FlightEntry(id: 'a', data: const {})))),
    );
    expect(
      AddFlightSuccess(2020, FlightEntry(id: 'a', data: const {})),
      isNot(
          equals(AddFlightSuccess(2020, FlightEntry(id: 'b', data: const {})))),
    );
    expect(
      AddFlightSuccess(2019, FlightEntry(id: 'a', data: const {})),
      isNot(
          equals(AddFlightSuccess(2020, FlightEntry(id: 'b', data: const {})))),
    );
  });

  test('test of AddFlightFailure ==', () {
    expect(
      AddFlightFailure(
        2020,
        FlightEntry(id: 'a', data: const {}),
      ),
      equals(AddFlightFailure(
        2020,
        FlightEntry(id: 'a', data: const {}),
      )),
    );
  });

  test('test of AddFlightFailure !=', () {
    expect(
      AddFlightFailure(
        2019,
        FlightEntry(id: 'a', data: const {}),
      ),
      isNot(equals(AddFlightFailure(
        2020,
        FlightEntry(id: 'a', data: const {}),
      ))),
    );
    expect(
      AddFlightFailure(
        2020,
        FlightEntry(id: 'a', data: const {}),
      ),
      isNot(equals(AddFlightFailure(
        2020,
        FlightEntry(id: 'b', data: const {}),
      ))),
    );
    expect(
      AddFlightFailure(
        2019,
        FlightEntry(id: 'a', data: const {}),
      ),
      isNot(equals(AddFlightFailure(
        2020,
        FlightEntry(id: 'b', data: const {}),
      ))),
    );
  });

  test('test of != for differnt types', () {
    expect(
      AddFlightInitial(),
      isNot(
          equals(AddFlightAdding(2020, FlightEntry(id: 'a', data: const {})))),
    );
    expect(
      AddFlightInitial(),
      isNot(
          equals(AddFlightSuccess(2020, FlightEntry(id: 'a', data: const {})))),
    );
    expect(
      AddFlightInitial(),
      isNot(
          equals(AddFlightFailure(2020, FlightEntry(id: 'a', data: const {})))),
    );

    expect(
      AddFlightAdding(2020, FlightEntry(id: 'a', data: const {})),
      isNot(equals(AddFlightInitial())),
    );
    expect(
      AddFlightAdding(2020, FlightEntry(id: 'a', data: const {})),
      isNot(
          equals(AddFlightSuccess(2020, FlightEntry(id: 'a', data: const {})))),
    );
    expect(
      AddFlightAdding(2020, FlightEntry(id: 'a', data: const {})),
      isNot(
          equals(AddFlightFailure(2020, FlightEntry(id: 'a', data: const {})))),
    );

    expect(
      AddFlightSuccess(2020, FlightEntry(id: 'a', data: const {})),
      isNot(equals(AddFlightInitial())),
    );
    expect(
      AddFlightSuccess(2020, FlightEntry(id: 'a', data: const {})),
      isNot(
          equals(AddFlightAdding(2020, FlightEntry(id: 'a', data: const {})))),
    );
    expect(
      AddFlightSuccess(2020, FlightEntry(id: 'a', data: const {})),
      isNot(
          equals(AddFlightFailure(2020, FlightEntry(id: 'a', data: const {})))),
    );

    expect(
      AddFlightFailure(2020, FlightEntry(id: 'a', data: const {})),
      isNot(equals(AddFlightInitial())),
    );
    expect(
      AddFlightFailure(2020, FlightEntry(id: 'a', data: const {})),
      isNot(
          equals(AddFlightAdding(2020, FlightEntry(id: 'a', data: const {})))),
    );
    expect(
      AddFlightFailure(2020, FlightEntry(id: 'a', data: const {})),
      isNot(
          equals(AddFlightSuccess(2020, FlightEntry(id: 'a', data: const {})))),
    );
  });
}
