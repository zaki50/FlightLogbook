import 'package:equatable/equatable.dart';
import 'package:flightlogbook/repository/authentication/current_user.dart';

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
