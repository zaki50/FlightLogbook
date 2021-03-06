import 'package:flightlogbook/bloc/authentication/authentication_event.dart';
import 'package:test/test.dart';

void main() {
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
