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
  final int year;

  FlightsLoading(this.year) : super([year]);

  @override
  String toString() => 'FlightsLoading';
}

class FlightsSuccess extends FlightsState {
  final int year;
  final List<FlightEntry> flights;

  FlightsSuccess(this.year, this.flights) : super([year, flights]);

  @override
  String toString() => 'FlightsSuccess';
}

class FlightsFailure extends FlightsState {
  final int year;

  FlightsFailure(this.year) : super([year]);

  @override
  String toString() => 'FlightsFailure';
}

class RemovingFlight extends FlightsState {
  final int year;
  final String flightId;

  RemovingFlight(this.year, this.flightId) : super([year, flightId]);

  @override
  String toString() => 'RemovingFlight';
}

class RemoveFlightSuccess extends FlightsState {
  final int year;
  final String flightId;

  RemoveFlightSuccess(this.year, this.flightId) : super([year, flightId]);

  @override
  String toString() => 'RemoveFlightSuccess';
}

class RemoveFlightFailure extends FlightsState {
  final int year;
  final String flightId;

  RemoveFlightFailure(this.year, this.flightId) : super([year, flightId]);

  @override
  String toString() => 'RemoveFlightFailure';
}
