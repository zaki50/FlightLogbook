import 'package:equatable/equatable.dart';
import 'package:flightlogbook/repository/flights/flight_entry.dart';

class MissingMandatoryPropertyException extends Equatable implements Exception {
  final String propertyName;

  MissingMandatoryPropertyException(this.propertyName);

  @override
  List<Object> get props => [propertyName];

  @override
  String toString() => "missing '${propertyName}' property";
}

class InvalidPropertyValueFormatException extends Equatable
    implements Exception {
  final String propertyName;

  InvalidPropertyValueFormatException(this.propertyName);

  @override
  List<Object> get props => [propertyName];

  @override
  String toString() => "missing '${propertyName}' property";
}

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
  final int year;
  final FlightEntry entry;

  AddFlightAdding(this.year, this.entry) : super([year, entry]);

  @override
  String toString() => 'AddFlightAdding';
}

class AddFlightSuccess extends AddFlightState {
  final int year;
  final FlightEntry entry;

  AddFlightSuccess(this.year, this.entry) : super([year, entry]);

  @override
  String toString() => 'AddFlightSuccess';
}

class AddFlightFailure extends AddFlightState {
  final int year;
  final FlightEntry entry;
  final Exception cause;

  AddFlightFailure(this.year, this.entry, [this.cause])
      : super([year, entry, cause]);

  @override
  String toString() => 'AddFlightFailure';
}
