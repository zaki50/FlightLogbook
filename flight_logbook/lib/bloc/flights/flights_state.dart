import 'package:equatable/equatable.dart';
import 'package:flightlogbook/bloc/flights/flight_entry.dart';

abstract class FlightsState extends Equatable {
  final List _props;

  FlightsState([this._props]);

  @override
  List<Object> get props => _props;
}

class FlightsInitial extends FlightsState {
  FlightsInitial();

  @override
  String toString() => 'FlightsInitial';
}

class FlightsLoading extends FlightsState {
  FlightsLoading();

  @override
  String toString() => 'FlightsLoading';
}

class FlightsSuccess extends FlightsState {
  final List<FlightEntry> flights;

  FlightsSuccess(this.flights) : super([flights]);

  @override
  String toString() => 'FlightsSuccess';
}

class FlightsFailure extends FlightsState {
  FlightsFailure();

  @override
  String toString() => 'FlightsFailure';
}

class RemovingFlight extends FlightsState {
  final String flightId;
  RemovingFlight(this.flightId) : super([flightId]);

  @override
  String toString() => 'RemovingFlight';
}

class RemoveFlightSuccess extends FlightsState {
  final String flightId;
  RemoveFlightSuccess(this.flightId) : super([flightId]);

  @override
  String toString() => 'RemoveFlightSuccess';
}

class RemoveFlightFailure extends FlightsState {
  final String flightId;
  RemoveFlightFailure(this.flightId) : super([flightId]);

  @override
  String toString() => 'RemoveFlightFailure';
}
