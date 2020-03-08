import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flightlogbook/bloc/authentication/authentication_bloc.dart';
import 'package:flightlogbook/bloc/authentication/authentication_event.dart';
import 'package:flightlogbook/bloc/authentication/authentication_repository.dart';
import 'package:flightlogbook/bloc/flights/flight_entry.dart';
import 'package:flightlogbook/bloc/flights/flights_bloc.dart';
import 'package:flightlogbook/bloc/flights/flights_event.dart';
import 'package:flightlogbook/bloc/flights/flights_repository.dart';
import 'package:flightlogbook/bloc/flights/flights_state.dart';
import 'package:flightlogbook/generated/i18n.dart';
import 'package:flightlogbook/main.dart';
import 'package:flightlogbook/pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FlightListScreen extends StatelessWidget {
  final _appBar = AppBar(title: const Text('Flight Logbook'));

  final FlightsBloc _flightsBloc = FlightsBloc(
    repository: FirestoreFlightsRepository(
      authRepository: FirebaseAuthenticationRepository(),
    ),
  );

  @override
  Widget build(BuildContext context) {
    final AuthenticationBloc authBloc = context.bloc();
    final S s = S.of(context);

    return Scaffold(
      appBar: _appBar,
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            ListTile(
              title: Text(s.logout),
              leading: Icon(FontAwesomeIcons.signOutAlt),
              onTap: () {
                AwesomeDialog(
                  context: context,
                  animType: AnimType.TOPSLIDE,
                  dialogType: DialogType.WARNING,
                  tittle: s.dialog_title_confirmation,
                  desc: s.confirm_logout,
                  btnOkOnPress: () => authBloc.add(LoggedOut()),
                  btnCancelOnPress: () => null,
                ).show();
              },
            ),
          ],
        ),
      ),
      body: BlocBuilder<FlightsBloc, FlightsState>(
        bloc: _flightsBloc,
        condition: (FlightsState previous, FlightsState current) =>
            !(current is RemovingFlight || current is RemoveFlightSuccess),
        builder: (context, state) {
          if (state is FlightsInitial) {
            _flightsBloc.add(LoadAllFlights());
            return Container();
          } else if (state is FlightsLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is FlightsSuccess) {
            return _buildFlightList(
              s,
              state.flights,
            );
          } else if (state is FlightsFailure) {
            return const Center(
              child: Text('データの読み込みに失敗しました。'),
            );
          } else if (state is RemoveFlightFailure) {
            Future.delayed(const Duration(seconds: 2),
                () => _flightsBloc.add(LoadAllFlights()));
            return const Center(
              child: Text('データの削除に失敗しました。'),
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

  Widget _buildFlightList(S s, List<FlightEntry> flights) {
    //要素を削除する場合があるのでコピー
    flights = List.from(flights);
    final double rowHeight = 48.0;

    // set single controller to each item in order to open at most one item.
    final SlidableController controller = SlidableController();
    final GlobalKey<AnimatedListState> listKey = GlobalKey();
    return RefreshIndicator(
      child: AnimatedList(
        key: listKey,
        initialItemCount: flights.length,
        itemBuilder: (
          BuildContext context,
          int index,
          Animation animation,
        ) {
          final FlightEntry item = flights[index];
          return _buildListItem(
            s,
            context,
            listKey,
            controller,
            animation,
            rowHeight,
            flights,
            item,
          );
        },
      ),
      onRefresh: () {
        _flightsBloc.add(LoadAllFlights());
        return Future.value();
      },
    );
  }

  Widget _buildListItem(
    S s,
    BuildContext context,
    GlobalKey<AnimatedListState> listKey,
    SlidableController controller,
    Animation animation,
    double rowHeight,
    List<FlightEntry> flights,
    FlightEntry item,
  ) =>
      SizeTransition(
        key: Key(item.id),
        sizeFactor: animation,
        child: Slidable(
          controller: controller,
          actionPane: const SlidableScrollActionPane(),
          actions: <Widget>[
            IconSlideAction(
              caption: s.actionLabel_delete,
              color: Colors.red,
              icon: Icons.delete,
              closeOnTap: false,
              onTap: () {
                AwesomeDialog(
                  context: context,
                  animType: AnimType.TOPSLIDE,
                  dialogType: DialogType.WARNING,
                  tittle: s.dialog_title_confirmation,
                  desc: s.confirm_delete_flight,
                  btnOkOnPress: () {
                    final removingIndex = flights.indexOf(item);
                    final removing = flights.removeAt(removingIndex);
                    AnimatedListRemovedItemBuilder builder =
                        (context, animation) {
                      return _buildListItem(
                        s,
                        context,
                        listKey,
                        controller,
                        animation,
                        rowHeight,
                        flights,
                        removing,
                      );
                    };
                    listKey.currentState.removeItem(removingIndex, builder);
                    _flightsBloc.add(RemoveFlight(removing.id));
                  },
                  btnCancelOnPress: () => null,
                ).show();
              },
            ),
          ],
          child: Container(
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  width: 0.5,
                  color: Colors.black38,
                ),
              ),
            ),
            child: Table(
              border: TableBorder.symmetric(
                inside: const BorderSide(
                  width: 0.5,
                  color: Colors.black38,
                ),
              ),
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
            ),
          ),
        ),
      );
}
