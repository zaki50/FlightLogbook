// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ja locale. All the
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
  String get localeName => 'ja';

  static m0(label) => "${label}を入力してください。";

  static m1(fieldName) => "${fieldName}の形式が正しくありません。";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "actionLabel_add" : MessageLookupByLibrary.simpleMessage("追加"),
    "actionLabel_delete" : MessageLookupByLibrary.simpleMessage("削除"),
    "confirm_delete_flight" : MessageLookupByLibrary.simpleMessage("フライトを削除しますか？"),
    "confirm_logout" : MessageLookupByLibrary.simpleMessage("ログアウトしますか？"),
    "dialog_title_confirmation" : MessageLookupByLibrary.simpleMessage("確認"),
    "dialog_title_error" : MessageLookupByLibrary.simpleMessage("エラー"),
    "error_empty_field" : m0,
    "error_failed_to_add_flight" : MessageLookupByLibrary.simpleMessage("フライトの作成に失敗しました。"),
    "error_invalid_value_format" : m1,
    "fieldName_AIRCRAFT_REGISTRATION" : MessageLookupByLibrary.simpleMessage("機体記号"),
    "fieldName_AIRCRAFT_TYPE" : MessageLookupByLibrary.simpleMessage("機材"),
    "fieldName_AIRLINE" : MessageLookupByLibrary.simpleMessage("航空会社"),
    "fieldName_ARRIVAL_AIRPORT" : MessageLookupByLibrary.simpleMessage("到着空港"),
    "fieldName_ARRIVAL_GATE" : MessageLookupByLibrary.simpleMessage("到着ゲート"),
    "fieldName_ARRIVAL_TIME" : MessageLookupByLibrary.simpleMessage("到着時刻"),
    "fieldName_ARRIVAL_TIMEZONE_" : MessageLookupByLibrary.simpleMessage("到着地タイムゾーン"),
    "fieldName_ARRIVAL_WEATHER" : MessageLookupByLibrary.simpleMessage("到着地の天候"),
    "fieldName_DEPARTURE_AIRPORT" : MessageLookupByLibrary.simpleMessage("出発空港"),
    "fieldName_DEPARTURE_DATE" : MessageLookupByLibrary.simpleMessage("搭乗日"),
    "fieldName_DEPARTURE_GATE" : MessageLookupByLibrary.simpleMessage("出発ゲート"),
    "fieldName_DEPARTURE_TIME" : MessageLookupByLibrary.simpleMessage("出発時刻"),
    "fieldName_DEPARTURE_TIMEZONE_" : MessageLookupByLibrary.simpleMessage("出発地タイムゾーン"),
    "fieldName_DEPARTURE_WEATHER" : MessageLookupByLibrary.simpleMessage("出発地の天候"),
    "fieldName_FLIGHT_NUMBER" : MessageLookupByLibrary.simpleMessage("便名"),
    "fieldName_LANDING_RUNWAY" : MessageLookupByLibrary.simpleMessage("着陸滑走路"),
    "fieldName_LANDING_TIME" : MessageLookupByLibrary.simpleMessage("着陸時刻"),
    "fieldName_MEMO" : MessageLookupByLibrary.simpleMessage("メモ"),
    "fieldName_SCHEDULED_ARRIVAL_TIME" : MessageLookupByLibrary.simpleMessage("到着予定時刻"),
    "fieldName_SCHEDULED_DEPARTURE_TIME" : MessageLookupByLibrary.simpleMessage("出発予定時刻"),
    "fieldName_SEAT_NUMBER" : MessageLookupByLibrary.simpleMessage("座席番号"),
    "fieldName_SERVICE_CLASS" : MessageLookupByLibrary.simpleMessage("サービスクラス"),
    "fieldName_TAKE_OFF_RUNWAY" : MessageLookupByLibrary.simpleMessage("離陸滑走路"),
    "fieldName_TAKE_OFF_TIME" : MessageLookupByLibrary.simpleMessage("離陸時刻"),
    "login" : MessageLookupByLibrary.simpleMessage("ログイン"),
    "loginIdLabel" : MessageLookupByLibrary.simpleMessage("メールアドレス"),
    "login_failure" : MessageLookupByLibrary.simpleMessage("ログインできませんでした。"),
    "logout" : MessageLookupByLibrary.simpleMessage("ログアウト"),
    "mandatory" : MessageLookupByLibrary.simpleMessage("(必須)"),
    "passwordLabel" : MessageLookupByLibrary.simpleMessage("パスワード"),
    "settingLabel_colorScheme" : MessageLookupByLibrary.simpleMessage("カラースキーム"),
    "settingValue_colorScheme_ana" : MessageLookupByLibrary.simpleMessage("ANA"),
    "settingValue_colorScheme_jal" : MessageLookupByLibrary.simpleMessage("JAL"),
    "settings" : MessageLookupByLibrary.simpleMessage("設定"),
    "showPassword" : MessageLookupByLibrary.simpleMessage("パスワードを表示")
  };
}
