import 'package:flightlogbook/bloc/authentication/current_user.dart';
import 'package:test/test.dart';

void main() {
  testFor_equals();
}

// ignore: non_constant_identifier_names
void testFor_equals() {
  test('test of ==', () {
    expect(CurrentUser(id: '12345', name: 'Bob'),
        equals(CurrentUser(id: '12345', name: 'Bob')));
  });

  test('test of !=', () {
    expect(CurrentUser(id: '12345', name: 'Bob'),
        isNot(equals(CurrentUser(id: '12345', name: 'Alice'))));
    expect(CurrentUser(id: '12345', name: 'Bob'),
        isNot(equals(CurrentUser(id: '24680', name: 'Bob'))));
    expect(CurrentUser(id: '12345', name: 'Bob'),
        isNot(equals(CurrentUser(id: '24680', name: 'Alice'))));
  });
}
