import 'package:equatable/equatable.dart';

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
