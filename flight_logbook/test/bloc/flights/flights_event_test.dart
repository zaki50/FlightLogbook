import 'package:flightlogbook/bloc/flights/flights_event.dart';
import 'package:test/test.dart';

void main() {
  testFor_equals();
}

void testFor_equals() {
  test('test of == for LoadAllFlights', () {
    expect(LoadAllFlights(2020), equals(LoadAllFlights(2020)));
  });

  test('test of != for LoadAllFlights', () {
    expect(LoadAllFlights(2019), isNot(equals(LoadAllFlights(2020))));
  });

  test('test of == for RemoveFlight', () {
    expect(RemoveFlight(2020, 'a'), equals(RemoveFlight(2020, 'a')));
  });

  test('test of != for RemoveFlight', () {
    expect(RemoveFlight(2019, 'a'), isNot(equals(RemoveFlight(2020, 'a'))));
    expect(RemoveFlight(2020, 'a'), isNot(equals(RemoveFlight(2020, 'b'))));
    expect(RemoveFlight(2019, 'a'), isNot(equals(RemoveFlight(2020, 'b'))));
  });

  test('test of !=', () {
    expect(LoadAllFlights(2020), isNot(equals(RemoveFlight(2020, 'a'))));
  });
}
