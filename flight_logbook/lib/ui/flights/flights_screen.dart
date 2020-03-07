import 'package:flightlogbook/bloc/authentication/authentication_repository.dart';
import 'package:flightlogbook/bloc/flights/flight_entry.dart';
import 'package:flightlogbook/bloc/flights/flights_bloc.dart';
import 'package:flightlogbook/bloc/flights/flights_event.dart';
import 'package:flightlogbook/bloc/flights/flights_repository.dart';
import 'package:flightlogbook/bloc/flights/flights_state.dart';
import 'package:flightlogbook/main.dart';
import 'package:flightlogbook/pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FlightListScreen extends StatelessWidget {
  final _appBar = AppBar(title: const Text('Flight Logbook'));

  final FlightsBloc _flightsBloc = FlightsBloc(
    repository: FirestoreFlightsRepository(
      authRepository: FirebaseAuthenticationRepository(),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar,
      body: BlocBuilder<FlightsBloc, FlightsState>(
        bloc: _flightsBloc,
        builder: (context, state) {
          if (state is FlightsInitial) {
            _flightsBloc.add(LoadAllFlights());
            return Container();
          } else if (state is FlightsLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is FlightsSuccess) {
            return _buildFlightList(state.flights, _flightsBloc);
          } else if (state is FlightsFailure) {
            return const Center(
              child: Text('データの読み込みに失敗しました。'),
            );
          }
          debugPrint("missing state branch for ${state.toString()}");
          return Container();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, Pages.ADD_FLIGHT),
        tooltip: 'Add',
        child: Icon(Icons.add),
        backgroundColor: const Color(MOHICAN_BLUE),
      ),
    );
  }

  Widget _buildFlightList(List<FlightEntry> flights, FlightsBloc flightsBloc) {
    final double rowHeight = 48.0;
    return RefreshIndicator(
      child: ListView.builder(
        itemCount: flights.length,
        itemBuilder: (BuildContext context, int index) {
          final FlightEntry item = flights[index];
          return Table(
            key: Key(item.id),
            border: TableBorder.all(width: 0.5),
            columnWidths: const {
              0: FixedColumnWidth(80.0),
              3: FixedColumnWidth(36.0),
              4: FixedColumnWidth(36.0),
            },
            children: [
              TableRow(children: [
                SizedBox(
                  height: rowHeight,
                  child: Center(
                    child: Text(item.data[FlightEntry.FIELD_DEPARTURE_DATE] ??
                        ''.toString()),
                  ),
                ),
                SizedBox(
                  height: rowHeight,
                  child: Center(
                      child: Text(item.data[FlightEntry.FIELD_AIRLINE] ??
                          ''.toString())),
                ),
                SizedBox(
                  height: rowHeight,
                  child: Center(
                    child: Text(item.data[FlightEntry.FIELD_FLIGHT_NUMBER] ??
                        ''.toString()),
                  ),
                ),
                SizedBox(
                  height: rowHeight,
                  child: Center(
                      child: Text(
                          item.data[FlightEntry.FIELD_DEPARTURE_AIRPORT] ??
                              ''.toString())),
                ),
                SizedBox(
                  height: rowHeight,
                  child: Center(
                      child: Text(
                          item.data[FlightEntry.FIELD_ARRIVAL_AIRPORT] ??
                              ''.toString())),
                ),
                SizedBox(
                  height: rowHeight,
                  child: Center(
                    child: Text(item.data[FlightEntry.FIELD_AIRCRAFT_TYPE] ??
                        ''.toString()),
                  ),
                ),
                SizedBox(
                  height: rowHeight,
                  child: Center(
                    child: Text(
                        item.data[FlightEntry.FIELD_AIRCRAFT_REGISTRATION] ??
                            ''.toString()),
                  ),
                ),
              ]),
            ],
          );
        },
      ),
      onRefresh: () {
        flightsBloc.add(LoadAllFlights());
        return Future.value();
      },
    );
  }
}
