import 'package:equatable/equatable.dart';

abstract class FlightsEvent extends Equatable {
  final List _props;

  FlightsEvent([this._props]);

  @override
  List<Object> get props => _props;
}

class LoadAllFlights extends FlightsEvent {
  @override
  String toString() => 'LoadAllFlights';
}
