import 'package:flightlogbook/bloc/flights/flight_entry.dart';
import 'package:test/test.dart';

void main() {
  testFor_equals();
}

// ignore: non_constant_identifier_names
void testFor_equals() {
  test('test of ==', () {
    expect(FlightEntry(id: '12345', data: const {'a': 'b'}),
        equals(FlightEntry(id: '12345', data: const {'a': 'b'})));
    // dataは等しくなくてもOK
    expect(FlightEntry(id: '12345', data: const {'a': 'b'}),
        equals(FlightEntry(id: '12345', data: const {'a': 'c'})));

    final forNew = FlightEntry.forNew(data: const {'a': 'b'});
    expect(forNew, equals(forNew));
  });

  test('test of !=', () {
    expect(FlightEntry(id: '12345', data: const {'a': 'b'}),
        isNot(equals(FlightEntry(id: '24680', data: const {'a': 'b'}))));

    // 別々に生成したforNewどうしは等しくない
    expect(FlightEntry.forNew(data: const {'a': 'b'}),
        isNot(equals(FlightEntry.forNew(data: const {'a': 'b'}))));
  });
}
