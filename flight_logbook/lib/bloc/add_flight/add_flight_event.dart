import 'package:equatable/equatable.dart';
import 'package:flightlogbook/repository/flights/flight_entry.dart';

abstract class AddFlightEvent extends Equatable {
  final List _props;

  AddFlightEvent([this._props]);

  @override
  List<Object> get props => _props;
}

class AddFlight extends AddFlightEvent {
  final int year;
  final FlightEntry entry;

  AddFlight(this.year, this.entry) : super([year, entry]);

  @override
  String toString() => 'AddFlight';
}
