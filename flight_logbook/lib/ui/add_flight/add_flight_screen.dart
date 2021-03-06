import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flightlogbook/bloc/add_flight/add_flight_bloc.dart';
import 'package:flightlogbook/bloc/add_flight/add_flight_event.dart';
import 'package:flightlogbook/bloc/add_flight/add_flight_state.dart';
import 'package:flightlogbook/generated/l10n.dart';
import 'package:flightlogbook/main.dart';
import 'package:flightlogbook/repository/authentication/authentication_repository.dart';
import 'package:flightlogbook/repository/flights/flight_entry.dart';
import 'package:flightlogbook/repository/flights/flights_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class AddFlightArguments {
  final int year;
  AddFlightArguments(this.year);
}

class AddFlightScreen extends StatefulWidget {
  @override
  _AddFlightScreenState createState() => _AddFlightScreenState();
}

class _FieldEntry {
  final String fieldName;
  final String valueExample;
  final bool mandatory;
  final TextEditingController editingController;

  _FieldEntry({
    @required this.fieldName,
    @required this.valueExample,
    this.mandatory = false,
  })  : assert(fieldName != null && fieldName.isNotEmpty),
        assert(valueExample != null && valueExample.isNotEmpty),
        assert(mandatory != null),
        editingController = TextEditingController();
}

class _AddFlightScreenState extends State<AddFlightScreen> {
  List<_FieldEntry> _fields;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _fields = [
      _FieldEntry(
        fieldName: FlightEntry.FIELD_DEPARTURE_DATE,
        valueExample: "例: ${DateFormat('MM/dd').format(DateTime.now())}",
        mandatory: true,
      ),
      _FieldEntry(
        fieldName: FlightEntry.FIELD_DEPARTURE_TIME,
        valueExample: "例: 1225",
        mandatory: true,
      ),
      _FieldEntry(
        fieldName: FlightEntry.FIELD_DEPARTURE_TIMEZONE,
        valueExample: "例: +0900",
        mandatory: true,
      ),
      _FieldEntry(
        fieldName: FlightEntry.FIELD_AIRLINE,
        valueExample: '例: ANA',
      ),
      _FieldEntry(
        fieldName: FlightEntry.FIELD_FLIGHT_NUMBER,
        valueExample: '例: NH885',
      ),
      _FieldEntry(
        fieldName: FlightEntry.FIELD_DEPARTURE_AIRPORT,
        valueExample: '例: HND',
      ),
      _FieldEntry(
        fieldName: FlightEntry.FIELD_ARRIVAL_AIRPORT,
        valueExample: '例: KUL',
      ),
      _FieldEntry(
        fieldName: FlightEntry.FIELD_AIRCRAFT_TYPE,
        valueExample: '例: B787-9',
      ),
      _FieldEntry(
        fieldName: FlightEntry.FIELD_AIRCRAFT_REGISTRATION,
        valueExample: '例: JA890A',
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final S s = S.of(context);
    final AddFlightArguments args = ModalRoute.of(context).settings.arguments;

    return BlocProvider(
      create: (_) => AddFlightBloc(
          repository: FirestoreFlightsRepository(
              authRepository: FirebaseAuthenticationRepository())),
      child: Builder(
        builder: (BuildContext context) => Scaffold(
          appBar: AppBar(
            title: Text("フライトを追加(${args.year}年度)"),
            actions: <Widget>[
              FlatButton(
                child: Text(
                  s.actionLabel_add,
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  if (_validateFields(s)) {
                    final AddFlightBloc bloc = context.bloc();
                    bloc.add(
                      AddFlight(
                        args.year,
                        FlightEntry.forNew(
                          data: _fields.asMap().map<String, dynamic>(
                                (_, _FieldEntry e) => MapEntry(
                                    e.fieldName, e.editingController.text),
                              ),
                        ),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
          body: BlocBuilder<AddFlightBloc, AddFlightState>(
            bloc: context.bloc(),
            builder: (BuildContext context, AddFlightState state) {
              if (state is AddFlightSuccess) {
                // close this screen
                Navigator.pop(context);
                return Container();
              }

              // state is AddFlightInitial || state is AddFlightAdding || state is AddFlightFailure

              if (state is AddFlightFailure) {
                final cause = state.cause;
                if (cause is InvalidPropertyValueFormatException) {
                  // このタイミングではダイアログをだせないので遅延実行する
                  Future.delayed(
                    const Duration(milliseconds: 10),
                    () => AwesomeDialog(
                      context: context,
                      animType: AnimType.TOPSLIDE,
                      dialogType: DialogType.ERROR,
                      tittle: s.dialog_title_error,
                      desc: s.error_invalid_value_format(
                          FlightEntry.toDisplayFieldName(
                              s, cause.propertyName)),
                      btnOkOnPress: () => null,
                    ).show(),
                  );
                } else {
                  Future.delayed(
                    const Duration(milliseconds: 10),
                    () => AwesomeDialog(
                      context: context,
                      animType: AnimType.TOPSLIDE,
                      dialogType: DialogType.ERROR,
                      tittle: s.dialog_title_error,
                      desc: s.error_failed_to_add_flight,
                      btnOkOnPress: () => null,
                    ).show(),
                  );
                }
              }
              return Stack(
                children: [
                  Form(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: _fields
                            .map(
                              (e) => _buildTextField(e, s),
                            )
                            .toList(),
                      ),
                    ),
                  ),
                  if (state is AddFlightAdding)
                    const AbsorbPointer(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  bool _validateFields(S s) => _fields.fold(
        true,
        (stillValid, e) =>
            stillValid &&
            (!e.mandatory ||
                _checkNotEmpty(context, s, e.editingController.text,
                    FlightEntry.toDisplayFieldName(s, e.fieldName))),
      );

  static Widget _buildTextField(_FieldEntry entry, S s) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        controller: entry.editingController,
        decoration: new InputDecoration(
          labelText:
              "${FlightEntry.toDisplayFieldName(s, entry.fieldName)}${entry.mandatory ? s.mandatory : ''}",
          hintText: entry.valueExample,
          border: new OutlineInputBorder(
              borderSide: new BorderSide(color: Color(TRITON_BLUE))),
        ),
      ),
    );
  }

  static bool _checkNotEmpty(
      BuildContext context, S s, String value, String label) {
    if (value.isNotEmpty) {
      return true;
    }
    AwesomeDialog(
      context: context,
      animType: AnimType.TOPSLIDE,
      dialogType: DialogType.ERROR,
      tittle: s.dialog_title_error,
      desc: s.error_empty_field(label),
      btnOkOnPress: () => null,
    ).show();
    return false;
  }
}
