import 'package:flightlogbook/bloc/login/login_state.dart';
import 'package:test/test.dart';

void main() {
  test('test of LoginInitial ==', () {
    expect(
      LoginInitial(),
      equals(LoginInitial()),
    );
  });

  test('test of LoginLoading ==', () {
    expect(
      LoginLoading(),
      equals(LoginLoading()),
    );
  });

  test('test of LoginSuccess ==', () {
    expect(
      LoginSuccess(),
      equals(LoginSuccess()),
    );
  });

  test('test of LoginFailure ==', () {
    expect(
      LoginFailure(),
      equals(LoginFailure()),
    );
  });

  test('test of != for differnt types', () {
    expect(
      LoginInitial(),
      isNot(equals(LoginLoading())),
    );
    expect(
      LoginInitial(),
      isNot(equals(LoginSuccess())),
    );
    expect(
      LoginInitial(),
      isNot(equals(LoginFailure())),
    );

    expect(
      LoginLoading(),
      isNot(equals(LoginInitial())),
    );
    expect(
      LoginLoading(),
      isNot(equals(LoginSuccess())),
    );
    expect(
      LoginLoading(),
      isNot(equals(LoginFailure())),
    );

    expect(
      LoginSuccess(),
      isNot(equals(LoginInitial())),
    );
    expect(
      LoginSuccess(),
      isNot(equals(LoginLoading())),
    );
    expect(
      LoginSuccess(),
      isNot(equals(LoginFailure())),
    );

    expect(
      LoginFailure(),
      isNot(equals(LoginInitial())),
    );
    expect(
      LoginFailure(),
      isNot(equals(LoginLoading())),
    );
    expect(
      LoginFailure(),
      isNot(equals(LoginSuccess())),
    );
  });
}
