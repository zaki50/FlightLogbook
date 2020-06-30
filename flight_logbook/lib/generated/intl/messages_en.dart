// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static m0(label) => "${label} is  mandatory.";

  static m1(fieldName) => "The format of ${fieldName} is invalid.";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "actionLabel_add" : MessageLookupByLibrary.simpleMessage("Add"),
    "actionLabel_delete" : MessageLookupByLibrary.simpleMessage("Delete"),
    "confirm_delete_flight" : MessageLookupByLibrary.simpleMessage("Delete this flight?"),
    "confirm_logout" : MessageLookupByLibrary.simpleMessage("Logout?"),
    "dialog_title_confirmation" : MessageLookupByLibrary.simpleMessage("Confirmation"),
    "dialog_title_error" : MessageLookupByLibrary.simpleMessage("Error"),
    "error_empty_field" : m0,
    "error_failed_to_add_flight" : MessageLookupByLibrary.simpleMessage("Failed to add flight."),
    "error_invalid_value_format" : m1,
    "fieldName_AIRCRAFT_REGISTRATION" : MessageLookupByLibrary.simpleMessage("Aircraft registration"),
    "fieldName_AIRCRAFT_TYPE" : MessageLookupByLibrary.simpleMessage("Aircraft type"),
    "fieldName_AIRLINE" : MessageLookupByLibrary.simpleMessage("Airline"),
    "fieldName_ARRIVAL_AIRPORT" : MessageLookupByLibrary.simpleMessage("Arrival airport"),
    "fieldName_ARRIVAL_GATE" : MessageLookupByLibrary.simpleMessage("Arrival gate"),
    "fieldName_ARRIVAL_TIME" : MessageLookupByLibrary.simpleMessage("Actual arrival time"),
    "fieldName_ARRIVAL_TIMEZONE_" : MessageLookupByLibrary.simpleMessage("Arrival timezone"),
    "fieldName_ARRIVAL_WEATHER" : MessageLookupByLibrary.simpleMessage("Arrival weather"),
    "fieldName_DEPARTURE_AIRPORT" : MessageLookupByLibrary.simpleMessage("Dep. airport"),
    "fieldName_DEPARTURE_DATE" : MessageLookupByLibrary.simpleMessage("Dep. date"),
    "fieldName_DEPARTURE_GATE" : MessageLookupByLibrary.simpleMessage("Dep. gate"),
    "fieldName_DEPARTURE_TIME" : MessageLookupByLibrary.simpleMessage("Actual departure time"),
    "fieldName_DEPARTURE_TIMEZONE_" : MessageLookupByLibrary.simpleMessage("Dep. timezone"),
    "fieldName_DEPARTURE_WEATHER" : MessageLookupByLibrary.simpleMessage("Dep. weather"),
    "fieldName_FLIGHT_NUMBER" : MessageLookupByLibrary.simpleMessage("Flight number"),
    "fieldName_LANDING_RUNWAY" : MessageLookupByLibrary.simpleMessage("Landing runway"),
    "fieldName_LANDING_TIME" : MessageLookupByLibrary.simpleMessage("Landing time"),
    "fieldName_MEMO" : MessageLookupByLibrary.simpleMessage("Memo"),
    "fieldName_SCHEDULED_ARRIVAL_TIME" : MessageLookupByLibrary.simpleMessage("Scheduled arrival time"),
    "fieldName_SCHEDULED_DEPARTURE_TIME" : MessageLookupByLibrary.simpleMessage("Scheduled departure time"),
    "fieldName_SEAT_NUMBER" : MessageLookupByLibrary.simpleMessage("Seat number"),
    "fieldName_SERVICE_CLASS" : MessageLookupByLibrary.simpleMessage("Service class"),
    "fieldName_TAKE_OFF_RUNWAY" : MessageLookupByLibrary.simpleMessage("Take-off runway"),
    "fieldName_TAKE_OFF_TIME" : MessageLookupByLibrary.simpleMessage("Take-off time"),
    "login" : MessageLookupByLibrary.simpleMessage("Login"),
    "loginIdLabel" : MessageLookupByLibrary.simpleMessage("Email"),
    "login_failure" : MessageLookupByLibrary.simpleMessage("Login failure"),
    "logout" : MessageLookupByLibrary.simpleMessage("Logout"),
    "mandatory" : MessageLookupByLibrary.simpleMessage("(mandatory)"),
    "passwordLabel" : MessageLookupByLibrary.simpleMessage("Password"),
    "settingLabel_colorScheme" : MessageLookupByLibrary.simpleMessage("Color scheme"),
    "settingValue_colorScheme_ana" : MessageLookupByLibrary.simpleMessage("ANA"),
    "settingValue_colorScheme_jal" : MessageLookupByLibrary.simpleMessage("JAL"),
    "settings" : MessageLookupByLibrary.simpleMessage("Settings"),
    "showPassword" : MessageLookupByLibrary.simpleMessage("Show password")
  };
}
