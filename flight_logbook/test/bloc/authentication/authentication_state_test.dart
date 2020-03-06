import 'package:flightlogbook/bloc/authentication/authentication_state.dart';
import 'package:flightlogbook/bloc/authentication/current_user.dart';
import 'package:test/test.dart';

void main() {
  testFor_equals();
}

// ignore: non_constant_identifier_names
void testFor_equals() {
  test('test of AuthenticationInProgress ==', () {
    expect(AuthenticationInProgress(), equals(AuthenticationInProgress()));
  });

  test('test of AuthenticationSuccess ==', () {
    expect(AuthenticationSuccess(CurrentUser(id: '12345', name: 'Bob')),
        equals(AuthenticationSuccess(CurrentUser(id: '12345', name: 'Bob'))));
  });

  test('test of AuthenticationSuccess !=', () {
    expect(
        AuthenticationSuccess(CurrentUser(id: '12345', name: 'Bob')),
        isNot(equals(
            AuthenticationSuccess(CurrentUser(id: '24680', name: 'Alice')))));
  });

  test('test of AuthenticationFalure ==', () {
    expect(AuthenticationFailure(), equals(AuthenticationFailure()));
  });

  test('test of != for differnt types', () {
    expect(
        AuthenticationInProgress(),
        isNot(equals(
            AuthenticationSuccess(CurrentUser(id: '12345', name: 'Bob')))));
    expect(AuthenticationInProgress(), isNot(equals(AuthenticationFailure())));
    expect(AuthenticationSuccess(CurrentUser(id: '12345', name: 'Bob')),
        isNot(equals(AuthenticationFailure())));
    expect(AuthenticationSuccess(CurrentUser(id: '12345', name: 'Bob')),
        isNot(equals(AuthenticationInProgress())));
    expect(
        AuthenticationFailure(),
        isNot(equals(
            AuthenticationSuccess(CurrentUser(id: '12345', name: 'Bob')))));
    expect(AuthenticationFailure(), isNot(equals(AuthenticationInProgress())));
  });
}
