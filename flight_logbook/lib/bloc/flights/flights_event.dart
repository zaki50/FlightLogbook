import 'package:equatable/equatable.dart';

abstract class FlightsEvent extends Equatable {
  final List _props;

  FlightsEvent([this._props]);

  @override
  List<Object> get props => _props;
}

class LoadAllFlights extends FlightsEvent {
  final int year;
  LoadAllFlights(this.year) : super([year]);

  @override
  String toString() => 'LoadAllFlights';
}

class RemoveFlight extends FlightsEvent {
  final int year;
  final String flightId;

  RemoveFlight(this.year, this.flightId) : super([year, flightId]);
  @override
  String toString() => 'RemoveFlight';
}
