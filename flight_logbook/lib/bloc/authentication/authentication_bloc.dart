import 'package:flightlogbook/bloc/authentication/authentication_event.dart';
import 'package:flightlogbook/bloc/authentication/authentication_state.dart';
import 'package:flightlogbook/repository/authentication/authentication_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationRepository _repository;

  AuthenticationBloc({
    @required AuthenticationRepository repository,
  })  : assert(repository != null),
        _repository = repository;

  @override
  AuthenticationState get initialState => AuthenticationInProgress();

  @override
  Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event) async* {
    if (event is AppStarted) {
      yield* _mapAppStartedToState();
    } else if (event is LoggedIn) {
      yield* _mapLoggedInToState();
    } else if (event is LoggedOut) {
      yield* _mapLoggedOutToState();
    }
  }

  Stream<AuthenticationState> _mapAppStartedToState() async* {
    try {
      final bool isLoggedIn = await _repository.isLoggedIn();
      if (isLoggedIn) {
        final currentUser = await _repository.getCurrentUser();
        yield AuthenticationSuccess(currentUser);
      } else {
        yield AuthenticationFailure();
      }
    } catch (_) {
      yield AuthenticationFailure();
    }
  }

  Stream<AuthenticationState> _mapLoggedInToState() async* {
    yield AuthenticationSuccess(await _repository.getCurrentUser());
  }

  Stream<AuthenticationState> _mapLoggedOutToState() async* {
    try {
      _repository.logout();
    } finally {
      yield AuthenticationFailure();
    }
  }
}
