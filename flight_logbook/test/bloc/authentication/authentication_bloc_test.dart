import 'package:flightlogbook/bloc/authentication/authentication_bloc.dart';
import 'package:flightlogbook/bloc/authentication/authentication_event.dart';
import 'package:flightlogbook/bloc/authentication/authentication_state.dart';
import 'package:flightlogbook/repository/authentication/authentication_repository.dart';
import 'package:flightlogbook/repository/authentication/current_user.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

class _MockAuthenticationRepository extends Mock
    implements AuthenticationRepository {}

void main() {
  test('test initial state', () {
    final mockRepository = _MockAuthenticationRepository();
    final bloc = AuthenticationBloc(repository: mockRepository);
    expectLater(bloc, emitsInOrder([AuthenticationInProgress()]));
    expectLater(bloc,
        neverEmits(AuthenticationSuccess(CurrentUser(id: 'a', name: 'Alice'))));
    expectLater(bloc, neverEmits(AuthenticationFailure()));
    bloc.close();
  });

  test('test auth success', () {
    final mockRepository = _MockAuthenticationRepository();
    when(mockRepository.isLoggedIn()).thenAnswer((_) => Future.value(true));
    when(mockRepository.getCurrentUser())
        .thenAnswer((_) => Future.value(CurrentUser(id: 'a', name: 'Alice')));
    final bloc = AuthenticationBloc(repository: mockRepository);
    expectLater(
        bloc,
        emitsInOrder([
          AuthenticationInProgress(),
          AuthenticationSuccess(CurrentUser(id: 'a', name: 'Alice')),
        ]));
    bloc.add(AppStarted());
  });

  test('test auth failure', () {
    final mockRepository = _MockAuthenticationRepository();
    when(mockRepository.isLoggedIn()).thenAnswer((_) => Future.value(false));
    final bloc = AuthenticationBloc(repository: mockRepository);
    expectLater(
        bloc,
        emitsInOrder([
          AuthenticationInProgress(),
          AuthenticationFailure(),
        ]));
    bloc.add(AppStarted());
  });

  test('test login event', () {
    final mockRepository = _MockAuthenticationRepository();
    when(mockRepository.getCurrentUser())
        .thenAnswer((_) => Future.value(CurrentUser(id: 'a', name: 'Alice')));
    final bloc = AuthenticationBloc(repository: mockRepository);
    expectLater(
        bloc,
        emitsInOrder([
          AuthenticationInProgress(),
          AuthenticationSuccess(CurrentUser(id: 'a', name: 'Alice')),
        ]));
    bloc.add(LoggedIn());
  });

  test('test logout event', () async {
    final mockRepository = _MockAuthenticationRepository();
    when(mockRepository.logout()).thenAnswer((_) {
      return;
    });
    final bloc = AuthenticationBloc(repository: mockRepository);
    final future = expectLater(
        bloc,
        emitsInOrder([
          AuthenticationInProgress(),
          AuthenticationFailure(),
        ]));
    bloc.add(LoggedOut());
    await future;
    verify(mockRepository.logout()).called(1);
  });
}
