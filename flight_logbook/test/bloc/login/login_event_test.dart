import 'package:flightlogbook/bloc/login/login_event.dart';
import 'package:test/test.dart';

void main() {
  testFor_equals();
}

void testFor_equals() {
  test('test of == for LoginWithGoogleOnPressed', () {
    expect(LoginWithGoogleOnPressed(), equals(LoginWithGoogleOnPressed()));
  });
}
