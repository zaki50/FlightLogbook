import 'package:equatable/equatable.dart';
import 'package:flightlogbook/bloc/authentication/authentication_repository.dart';
import 'package:flightlogbook/bloc/authentication/current_user.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class AuthenticationState extends Equatable {
  final List _props;

  AuthenticationState([this._props]);

  @override
  List<Object> get props => _props;
}

class AuthenticationInProgress extends AuthenticationState {
  AuthenticationInProgress() : super([]);

  @override
  String toString() => 'Uninitialized';
}

class AuthenticationSuccess extends AuthenticationState {
  final CurrentUser currentUser;
  AuthenticationSuccess(this.currentUser) : super([currentUser]);

  @override
  String toString() => 'AuthenticationSuccess';
}

class AuthenticationFailure extends AuthenticationState {
  AuthenticationFailure() : super([]);

  @override
  String toString() => 'AuthenticationFailure';
}

abstract class AuthenticationEvent extends Equatable {
  final List _props;

  AuthenticationEvent([this._props]);

  @override
  List<Object> get props => _props;
}

class AppStarted extends AuthenticationEvent {
  @override
  String toString() => 'AppStarted';
}

class LoggedIn extends AuthenticationEvent {
  @override
  String toString() => 'LoggedIn';
}

class LoggedOut extends AuthenticationEvent {
  @override
  String toString() => 'LoggedOut';
}

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
    yield AuthenticationFailure();
    _repository.logout();
  }
}
