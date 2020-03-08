import 'package:equatable/equatable.dart';
import 'package:flightlogbook/bloc/flights/flight_entry.dart';

abstract class AddFlightState extends Equatable {
  final List _props;

  AddFlightState([this._props]);

  @override
  List<Object> get props => _props;
}

class AddFlightInitial extends AddFlightState {
  AddFlightInitial();

  @override
  String toString() => 'AddFlightInitial';
}

class AddFlightAdding extends AddFlightState {
  @override
  String toString() => 'AddFlightAdding';
}

class AddFlightSuccess extends AddFlightState {
  final FlightEntry entry;
  AddFlightSuccess(this.entry) : super([entry]);

  @override
  String toString() => 'AddFlightSuccess';
}

class AddFlightFailure extends AddFlightState {
  AddFlightFailure();

  @override
  String toString() => 'AddFlightFailure';
}
