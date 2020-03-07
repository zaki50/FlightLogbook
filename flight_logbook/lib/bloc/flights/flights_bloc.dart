import 'package:equatable/equatable.dart';
import 'package:flightlogbook/bloc/flights/flight_entry.dart';
import 'package:flightlogbook/bloc/flights/flights_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

class FlightsBloc extends Bloc<FlightsEvent, FlightsState> {
  final FlightsRepository _repository;

  FlightsBloc({
    @required FlightsRepository repository,
  })  : assert(repository != null),
        _repository = repository;

  @override
  FlightsState get initialState => FlightsInitial();

  @override
  Stream<FlightsState> mapEventToState(FlightsEvent event) async* {
    if (event is LoadAllFlights) {
      yield* _mapLoadAllFlightsToState();
    }
  }

  Stream<FlightsState> _mapLoadAllFlightsToState() async* {
    yield FlightsLoading();
    try {
      final List<FlightEntry> allFlights = await _repository.getAllFlights();
      yield FlightsSuccess(allFlights);
    } catch (_) {
      yield FlightsFailure();
    }
  }
}
