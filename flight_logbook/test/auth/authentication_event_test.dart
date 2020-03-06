import 'package:flightlogbook/auth/authentication_event.dart';
import 'package:flightlogbook/auth/authentication_state.dart';
import 'package:flightlogbook/auth/current_user.dart';
import 'package:test/test.dart';

void main() {
  testFor_equals();
}

// ignore: non_constant_identifier_names
void testFor_equals() {
  test('test of == for AppStarted', () {
    expect(AppStarted(), equals(AppStarted()));
  });

  test('test of == for LoggedIn', () {
    expect(LoggedIn(), equals(LoggedIn()));
  });

  test('test of == for LoggedOut', () {
    expect(LoggedOut(), equals(LoggedOut()));
  });

  test('test of !=', () {
    expect(AppStarted(), isNot(equals(LoggedIn())));
    expect(AppStarted(), isNot(equals(LoggedOut())));
    expect(LoggedIn(), isNot(equals(AppStarted())));
    expect(LoggedIn(), isNot(equals(LoggedOut())));
    expect(LoggedOut(), isNot(equals(AppStarted())));
    expect(LoggedOut(), isNot(equals(LoggedIn())));
  });
}
