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
