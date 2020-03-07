import 'package:equatable/equatable.dart';
import 'package:flightlogbook/bloc/login/login_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class LoginState extends Equatable {
  final List _props;

  LoginState([this._props]);

  @override
  List<Object> get props => _props;
}

class LoginInitial extends LoginState {
  LoginInitial();

  @override
  String toString() => 'LoginInitial';
}

class LoginLoading extends LoginState {
  LoginLoading();

  @override
  String toString() => 'LoginLoading';
}

class LoginSuccess extends LoginState {
  LoginSuccess();

  @override
  String toString() => 'LoginSuccess';
}

class LoginFailure extends LoginState {
  LoginFailure();

  @override
  String toString() => 'LoginFailure';
}

abstract class LoginEvent extends Equatable {
  final List _props;

  LoginEvent([this._props]);

  @override
  List<Object> get props => _props;
}

class LoginWithGoogleOnPressed extends LoginEvent {
  @override
  String toString() => 'LoginWithGoogleOnPressed';
}

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginRepository _repository;
  LoginBloc({
    @required LoginRepository repository,
  })  : assert(repository != null),
        _repository = repository;

  @override
  LoginState get initialState => LoginInitial();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginWithGoogleOnPressed) {
      yield* _mapLoginWithGoogleOnPressedToState();
    }
  }

  Stream<LoginState> _mapLoginWithGoogleOnPressedToState() async* {
    yield LoginLoading();
    try {
      await _repository.loginWithGoogle();
      yield LoginSuccess();
    } catch (_) {
      yield LoginFailure();
    }
  }
}
