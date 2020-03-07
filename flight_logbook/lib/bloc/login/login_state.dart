import 'package:equatable/equatable.dart';

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
