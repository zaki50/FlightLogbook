import 'package:equatable/equatable.dart';
import 'package:flightlogbook/bloc/flights/flight_entry.dart';

abstract class AddFlightEvent extends Equatable {
  final List _props;

  AddFlightEvent([this._props]);

  @override
  List<Object> get props => _props;
}

class AddFlight extends AddFlightEvent {
  final FlightEntry entry;

  AddFlight(this.entry) : super([entry]);

  @override
  String toString() => 'AddFlight';
}
