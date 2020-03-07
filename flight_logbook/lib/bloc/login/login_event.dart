import 'package:equatable/equatable.dart';

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
