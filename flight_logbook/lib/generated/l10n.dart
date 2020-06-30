// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars

class S {
  S();
  
  static S current;
  
  static const AppLocalizationDelegate delegate =
    AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false) ? locale.languageCode : locale.toString();
    final localeName = Intl.canonicalizedLocale(name); 
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      S.current = S();
      
      return S.current;
    });
  } 

  static S of(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Email`
  String get loginIdLabel {
    return Intl.message(
      'Email',
      name: 'loginIdLabel',
      desc: 'Label for login id',
      args: [],
    );
  }

  /// `Password`
  String get passwordLabel {
    return Intl.message(
      'Password',
      name: 'passwordLabel',
      desc: 'Label for login password',
      args: [],
    );
  }

  /// `Show password`
  String get showPassword {
    return Intl.message(
      'Show password',
      name: 'showPassword',
      desc: 'Show password label',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message(
      'Login',
      name: 'login',
      desc: 'Label for login button',
      args: [],
    );
  }

  /// `Login failure`
  String get login_failure {
    return Intl.message(
      'Login failure',
      name: 'login_failure',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get logout {
    return Intl.message(
      'Logout',
      name: 'logout',
      desc: '',
      args: [],
    );
  }

  /// `Error`
  String get dialog_title_error {
    return Intl.message(
      'Error',
      name: 'dialog_title_error',
      desc: '',
      args: [],
    );
  }

  /// `Confirmation`
  String get dialog_title_confirmation {
    return Intl.message(
      'Confirmation',
      name: 'dialog_title_confirmation',
      desc: '',
      args: [],
    );
  }

  /// `Logout?`
  String get confirm_logout {
    return Intl.message(
      'Logout?',
      name: 'confirm_logout',
      desc: '',
      args: [],
    );
  }

  /// `Delete this flight?`
  String get confirm_delete_flight {
    return Intl.message(
      'Delete this flight?',
      name: 'confirm_delete_flight',
      desc: '',
      args: [],
    );
  }

  /// `Failed to add flight.`
  String get error_failed_to_add_flight {
    return Intl.message(
      'Failed to add flight.',
      name: 'error_failed_to_add_flight',
      desc: '',
      args: [],
    );
  }

  /// `The format of {fieldName} is invalid.`
  String error_invalid_value_format(Object fieldName) {
    return Intl.message(
      'The format of $fieldName is invalid.',
      name: 'error_invalid_value_format',
      desc: '',
      args: [fieldName],
    );
  }

  /// `{label} is  mandatory.`
  String error_empty_field(Object label) {
    return Intl.message(
      '$label is  mandatory.',
      name: 'error_empty_field',
      desc: '',
      args: [label],
    );
  }

  /// `Add`
  String get actionLabel_add {
    return Intl.message(
      'Add',
      name: 'actionLabel_add',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get actionLabel_delete {
    return Intl.message(
      'Delete',
      name: 'actionLabel_delete',
      desc: '',
      args: [],
    );
  }

  /// `(mandatory)`
  String get mandatory {
    return Intl.message(
      '(mandatory)',
      name: 'mandatory',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Color scheme`
  String get settingLabel_colorScheme {
    return Intl.message(
      'Color scheme',
      name: 'settingLabel_colorScheme',
      desc: '',
      args: [],
    );
  }

  /// `ANA`
  String get settingValue_colorScheme_ana {
    return Intl.message(
      'ANA',
      name: 'settingValue_colorScheme_ana',
      desc: '',
      args: [],
    );
  }

  /// `JAL`
  String get settingValue_colorScheme_jal {
    return Intl.message(
      'JAL',
      name: 'settingValue_colorScheme_jal',
      desc: '',
      args: [],
    );
  }

  /// `Dep. date`
  String get fieldName_DEPARTURE_DATE {
    return Intl.message(
      'Dep. date',
      name: 'fieldName_DEPARTURE_DATE',
      desc: '',
      args: [],
    );
  }

  /// `Airline`
  String get fieldName_AIRLINE {
    return Intl.message(
      'Airline',
      name: 'fieldName_AIRLINE',
      desc: '',
      args: [],
    );
  }

  /// `Flight number`
  String get fieldName_FLIGHT_NUMBER {
    return Intl.message(
      'Flight number',
      name: 'fieldName_FLIGHT_NUMBER',
      desc: '',
      args: [],
    );
  }

  /// `Service class`
  String get fieldName_SERVICE_CLASS {
    return Intl.message(
      'Service class',
      name: 'fieldName_SERVICE_CLASS',
      desc: '',
      args: [],
    );
  }

  /// `Seat number`
  String get fieldName_SEAT_NUMBER {
    return Intl.message(
      'Seat number',
      name: 'fieldName_SEAT_NUMBER',
      desc: '',
      args: [],
    );
  }

  /// `Aircraft type`
  String get fieldName_AIRCRAFT_TYPE {
    return Intl.message(
      'Aircraft type',
      name: 'fieldName_AIRCRAFT_TYPE',
      desc: '',
      args: [],
    );
  }

  /// `Aircraft registration`
  String get fieldName_AIRCRAFT_REGISTRATION {
    return Intl.message(
      'Aircraft registration',
      name: 'fieldName_AIRCRAFT_REGISTRATION',
      desc: '',
      args: [],
    );
  }

  /// `Dep. airport`
  String get fieldName_DEPARTURE_AIRPORT {
    return Intl.message(
      'Dep. airport',
      name: 'fieldName_DEPARTURE_AIRPORT',
      desc: '',
      args: [],
    );
  }

  /// `Arrival airport`
  String get fieldName_ARRIVAL_AIRPORT {
    return Intl.message(
      'Arrival airport',
      name: 'fieldName_ARRIVAL_AIRPORT',
      desc: '',
      args: [],
    );
  }

  /// `Dep. gate`
  String get fieldName_DEPARTURE_GATE {
    return Intl.message(
      'Dep. gate',
      name: 'fieldName_DEPARTURE_GATE',
      desc: '',
      args: [],
    );
  }

  /// `Arrival gate`
  String get fieldName_ARRIVAL_GATE {
    return Intl.message(
      'Arrival gate',
      name: 'fieldName_ARRIVAL_GATE',
      desc: '',
      args: [],
    );
  }

  /// `Dep. weather`
  String get fieldName_DEPARTURE_WEATHER {
    return Intl.message(
      'Dep. weather',
      name: 'fieldName_DEPARTURE_WEATHER',
      desc: '',
      args: [],
    );
  }

  /// `Arrival weather`
  String get fieldName_ARRIVAL_WEATHER {
    return Intl.message(
      'Arrival weather',
      name: 'fieldName_ARRIVAL_WEATHER',
      desc: '',
      args: [],
    );
  }

  /// `Dep. timezone`
  String get fieldName_DEPARTURE_TIMEZONE_ {
    return Intl.message(
      'Dep. timezone',
      name: 'fieldName_DEPARTURE_TIMEZONE_',
      desc: '',
      args: [],
    );
  }

  /// `Arrival timezone`
  String get fieldName_ARRIVAL_TIMEZONE_ {
    return Intl.message(
      'Arrival timezone',
      name: 'fieldName_ARRIVAL_TIMEZONE_',
      desc: '',
      args: [],
    );
  }

  /// `Scheduled departure time`
  String get fieldName_SCHEDULED_DEPARTURE_TIME {
    return Intl.message(
      'Scheduled departure time',
      name: 'fieldName_SCHEDULED_DEPARTURE_TIME',
      desc: '',
      args: [],
    );
  }

  /// `Scheduled arrival time`
  String get fieldName_SCHEDULED_ARRIVAL_TIME {
    return Intl.message(
      'Scheduled arrival time',
      name: 'fieldName_SCHEDULED_ARRIVAL_TIME',
      desc: '',
      args: [],
    );
  }

  /// `Actual departure time`
  String get fieldName_DEPARTURE_TIME {
    return Intl.message(
      'Actual departure time',
      name: 'fieldName_DEPARTURE_TIME',
      desc: '',
      args: [],
    );
  }

  /// `Actual arrival time`
  String get fieldName_ARRIVAL_TIME {
    return Intl.message(
      'Actual arrival time',
      name: 'fieldName_ARRIVAL_TIME',
      desc: '',
      args: [],
    );
  }

  /// `Take-off time`
  String get fieldName_TAKE_OFF_TIME {
    return Intl.message(
      'Take-off time',
      name: 'fieldName_TAKE_OFF_TIME',
      desc: '',
      args: [],
    );
  }

  /// `Landing time`
  String get fieldName_LANDING_TIME {
    return Intl.message(
      'Landing time',
      name: 'fieldName_LANDING_TIME',
      desc: '',
      args: [],
    );
  }

  /// `Take-off runway`
  String get fieldName_TAKE_OFF_RUNWAY {
    return Intl.message(
      'Take-off runway',
      name: 'fieldName_TAKE_OFF_RUNWAY',
      desc: '',
      args: [],
    );
  }

  /// `Landing runway`
  String get fieldName_LANDING_RUNWAY {
    return Intl.message(
      'Landing runway',
      name: 'fieldName_LANDING_RUNWAY',
      desc: '',
      args: [],
    );
  }

  /// `Memo`
  String get fieldName_MEMO {
    return Intl.message(
      'Memo',
      name: 'fieldName_MEMO',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ja'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    if (locale != null) {
      for (var supportedLocale in supportedLocales) {
        if (supportedLocale.languageCode == locale.languageCode) {
          return true;
        }
      }
    }
    return false;
  }
}