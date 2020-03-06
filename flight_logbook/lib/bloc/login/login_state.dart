import 'package:equatable/equatable.dart';

abstract class LoginState extends Equatable {
  final List _props;

  LoginState([this._props]);

  @override
  List<Object> get props => _props;
}

class LoginEmpty extends LoginState {
  LoginEmpty();

  @override
  String toString() => 'LoginEmpty';
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
