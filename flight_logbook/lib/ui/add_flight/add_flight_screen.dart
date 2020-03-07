import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flightlogbook/bloc/flights/flight_entry.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddFlightScreen extends StatefulWidget {
  @override
  _AddFlightScreenState createState() => _AddFlightScreenState();
}

class _AddFlightScreenState extends State<AddFlightScreen> {
  final _departureDateController = TextEditingController();
  final _airlineController = TextEditingController();
  final _flightNumberController = TextEditingController();
  final _departureAirportController = TextEditingController();
  final _arrivalAirportController = TextEditingController();
  final _aircraftTypeController = TextEditingController();
  final _aircraftRegistrationController = TextEditingController();

  bool _isSaving;

  @override
  void initState() {
    super.initState();
    _isSaving = false;
  }

  @override
  Widget build(BuildContext context) {
    final df = DateFormat('yyyy/MM/dd');
    return Scaffold(
      appBar: AppBar(
        title: const Text('フライトを追加'),
        actions: <Widget>[
          FlatButton(
            child: const Text(
              '追加',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () async {
              if (_validateFields()) {
                // TODO: ちゃんとBlocで実装する

                final uid = (await FirebaseAuth.instance.currentUser()).uid;
                await Firestore.instance.collection("/users/$uid/flights").add(
                  {
                    FlightEntry.FIELD_DEPARTURE_DATE:
                        _departureDateController.text,
                    FlightEntry.FIELD_AIRLINE: _airlineController.text,
                    FlightEntry.FIELD_FLIGHT_NUMBER:
                        _flightNumberController.text,
                    FlightEntry.FIELD_FROM: _departureAirportController.text,
                    FlightEntry.FIELD_TO: _arrivalAirportController.text,
                    FlightEntry.FIELD_AIRCRAFT_TYPE:
                        _aircraftTypeController.text,
                    FlightEntry.FIELD_AIRCRAFT_REGISTRATION:
                        _aircraftRegistrationController.text,
                    FlightEntry.FIELD_UID: uid,
                  },
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
            children: <Widget>[
              _buildTextField(
                  _departureDateController, '搭乗日', df.format(DateTime.now())),
              _buildTextField(_airlineController, '航空会社', 'ANA'),
              _buildTextField(_flightNumberController, '便名', 'NH885'),
              _buildTextField(_departureAirportController, '出発空港', 'HND'),
              _buildTextField(_arrivalAirportController, '到着空港', 'KUL'),
              _buildTextField(_aircraftTypeController, '機材', 'B787-9'),
              _buildTextField(
                  _aircraftRegistrationController, '機体記号', 'JA890A'),
            ],
          ),
        ),
      ),
    );
  }

  bool _validateFields() {
    if (!_checkNotEmpty(context, _departureDateController.text, '搭乗日')) {
      return false;
    }
    if (!_checkNotEmpty(context, _airlineController.text, '航空会社')) {
      return false;
    }
    if (!_checkNotEmpty(context, _flightNumberController.text, '便名')) {
      return false;
    }
    if (!_checkNotEmpty(context, _departureAirportController.text, '出発空港')) {
      return false;
    }
    if (!_checkNotEmpty(context, _arrivalAirportController.text, '到着空港')) {
      return false;
    }
    if (!_checkNotEmpty(context, _aircraftTypeController.text, '機材')) {
      return false;
    }
    if (!_checkNotEmpty(
        context, _aircraftRegistrationController.text, '機体記号')) {
      return false;
    }
    return true;
  }

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
