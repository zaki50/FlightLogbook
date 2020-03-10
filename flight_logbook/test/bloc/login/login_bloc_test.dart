import 'package:flightlogbook/bloc/login/login_bloc.dart';
import 'package:flightlogbook/bloc/login/login_event.dart';
import 'package:flightlogbook/bloc/login/login_state.dart';
import 'package:flightlogbook/repository/login/login_repository.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

class _MockLoginRepository extends Mock implements LoginRepository {}

void main() {
  test('test initial state', () {
    final LoginRepository mockLoginRepository = _MockLoginRepository();
    final bloc = LoginBloc(repository: mockLoginRepository);
    expectLater(bloc, emitsInOrder([LoginInitial()]));
    expectLater(bloc, neverEmits(LoginLoading()));
    expectLater(bloc, neverEmits(LoginSuccess()));
    expectLater(bloc, neverEmits(LoginFailure()));
    bloc.close();
  });

  test('test Google login success', () {
    final LoginRepository mockLoginRepository = _MockLoginRepository();
    when(mockLoginRepository.loginWithGoogle()).thenAnswer((_) {
      return;
    });
    final bloc = LoginBloc(repository: mockLoginRepository);
    expectLater(
        bloc, emitsInOrder([LoginInitial(), LoginLoading(), LoginSuccess()]));
    bloc.add(LoginWithGoogleOnPressed());
  });

  test('test Google login failure', () {
    final LoginRepository mockLoginRepository = _MockLoginRepository();
    when(mockLoginRepository.loginWithGoogle()).thenThrow(Exception());
    final bloc = LoginBloc(repository: mockLoginRepository);
    expectLater(
        bloc, emitsInOrder([LoginInitial(), LoginLoading(), LoginFailure()]));
    bloc.add(LoginWithGoogleOnPressed());
  });
}
