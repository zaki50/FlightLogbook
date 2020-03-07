import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flightlogbook/bloc/flights/flight_entry.dart';
import 'package:flightlogbook/generated/i18n.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddFlightScreen extends StatefulWidget {
  @override
  _AddFlightScreenState createState() => _AddFlightScreenState();
}

class _FieldEntry {
  final String fieldName;
  final String label;
  final String valueExample;
  final bool mandatory;
  final TextEditingController editingController;

  _FieldEntry({
    @required this.fieldName,
    @required this.label,
    @required this.valueExample,
    this.mandatory = false,
  })  : assert(fieldName != null && fieldName.isNotEmpty),
        assert(label != null && label.isNotEmpty),
        assert(valueExample != null && valueExample.isNotEmpty),
        assert(mandatory != null),
        editingController = TextEditingController();
}

class _AddFlightScreenState extends State<AddFlightScreen> {
  List<_FieldEntry> _fields;

  bool _isSaving;

  @override
  void initState() {
    super.initState();
    _isSaving = false;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final S s = S.of(context);
    _fields = [
      _FieldEntry(
        fieldName: FlightEntry.FIELD_DEPARTURE_DATE,
        label: s.flightFieldLabel_departureDate,
        valueExample: "例: ${DateFormat('yyyy/MM/dd').format(DateTime.now())}",
        mandatory: true,
      ),
      _FieldEntry(
        fieldName: FlightEntry.FIELD_AIRLINE,
        label: s.flightFieldLabel_airline,
        valueExample: '例: ANA',
      ),
      _FieldEntry(
        fieldName: FlightEntry.FIELD_FLIGHT_NUMBER,
        label: s.flightFieldLabel_flightNumber,
        valueExample: '例: NH885',
      ),
      _FieldEntry(
        fieldName: FlightEntry.FIELD_DEPARTURE_AIRPORT,
        label: s.flightFieldLabel_departureAirport,
        valueExample: '例: HND',
      ),
      _FieldEntry(
        fieldName: FlightEntry.FIELD_ARRIVAL_AIRPORT,
        label: s.flightFieldLabel_arrivalAirport,
        valueExample: '例: KUL',
      ),
      _FieldEntry(
        fieldName: FlightEntry.FIELD_AIRCRAFT_TYPE,
        label: s.flightFieldLabel_aircraftType,
        valueExample: '例: B787-9',
      ),
      _FieldEntry(
        fieldName: FlightEntry.FIELD_AIRCRAFT_REGISTRATION,
        label: s.flightFieldLabel_aircraftRegistration,
        valueExample: '例: JA890A',
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final S s = S.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('フライトを追加'),
        actions: <Widget>[
          FlatButton(
            child: Text(
              s.actionLabel_add,
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () async {
              if (_validateFields()) {
                // TODO: ちゃんとBlocで実装する

                final String uid =
                    (await FirebaseAuth.instance.currentUser()).uid;
                await Firestore.instance.collection("/users/$uid/flights").add(
                      _fields.asMap().map<String, dynamic>(
                            (_, _FieldEntry e) =>
                                MapEntry(e.fieldName, e.editingController.text),
                          )..putIfAbsent(FlightEntry.FIELD_UID, () => uid),
                    );
                Navigator.pop(context);
              }
            },
          ),
        ],
      ),
      body: Form(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: _fields
                .map(
                  (e) => _buildTextField(
                    e.editingController,
                    e.label,
                    e.valueExample,
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }

  bool _validateFields() => _fields.fold(
        true,
        (stillValid, e) =>
            stillValid &&
            (!e.mandatory ||
                _checkNotEmpty(context, e.editingController.text, e.label)),
      );

  static Widget _buildTextField(
      TextEditingController controller, String labelText, String hintText) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        controller: controller,
        decoration: new InputDecoration(
          labelText: labelText,
          hintText: hintText,
          border: new OutlineInputBorder(
              borderSide: new BorderSide(color: Colors.black)),
        ),
      ),
    );
  }

  static bool _checkNotEmpty(BuildContext context, String value, String label) {
    if (value.isNotEmpty) {
      return true;
    }
    AwesomeDialog(
      context: context,
      animType: AnimType.TOPSLIDE,
      dialogType: DialogType.WARNING,
      tittle: 'エラー',
      desc: "${label}が空です。",
      btnOkOnPress: () => null,
    ).show();
    return false;
  }
}
