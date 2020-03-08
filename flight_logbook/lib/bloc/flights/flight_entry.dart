import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class FlightEntry extends Equatable {
  final String id;
  final Map<String, dynamic> data;

  static const FIELD_UID = 'uid'; // ユーザーのID
  static const FIELD_DEPARTURE_DATE = 'system:departure_date'; // 搭乗日
  static const FIELD_AIRLINE = 'system:airline'; // 航空会社
  static const FIELD_FLIGHT_NUMBER = 'system:flight_number'; // 便名
  static const FIELD_SERVICE_CLASS = 'system:service_class'; // 座席クラス
  static const FIELD_SEAT_NUMBER = 'system:seat_number'; // 座席番号
  static const FIELD_AIRCRAFT_TYPE = 'system:aricraft_type'; // 機種
  static const FIELD_AIRCRAFT_REGISTRATION =
      'system:aricraft_registration'; // 機体記号
  static const FIELD_DEPARTURE_AIRPORT = 'system:departure_airport'; // 出発空港
  static const FIELD_ARRIVAL_AIRPORT = 'system:arrival_airport'; // 到着空港
  static const FIELD_DEPARTURE_GATE = 'system:departure_gate'; // 出発ゲート
  static const FIELD_ARRIVAL_GATE = 'system:arrival_gate'; // 到着ゲート
  static const FIELD_DEPARTURE_WEATHER = 'system:departure_weather'; // 出発空港の天候
  static const FIELD_ARRIVAL_WEATHER = 'system:arrival_weather'; // 到着空港の天候

  static const FIELD_SCHEDULED_DEPARTURE_TIME =
      'system:scheduled_departure_time'; // 出発予定時刻
  static const FIELD_SCHEDULED_ARRIVAL_TIME =
      'system:scheduled_arrival_time'; // 到着予定時刻
  static const FIELD_DEPARTURE_TIME = 'system:departure_time'; // 出発時刻
  static const FIELD_ARRIVAL_TIME = 'system:arrival_time'; // 到着時刻
  static const FIELD_TAKE_OFF_TIME = 'system:take_off_time'; // 離陸時刻
  static const FIELD_LANDING_TIME = 'system:landing_time'; // 着陸時刻
  static const FIELD_TAKE_OFF_RUNWAY = 'system:take_off_runway'; // 離陸時刻
  static const FIELD_LANDING_RUNWAY = 'system:landing_runway'; // 着陸時刻
  static const FIELD_MEMO = 'system:memo'; // メモ

  FlightEntry({
    @required this.id,
    @required this.data,
  })  : assert(id != null && id.isNotEmpty),
        assert(data != null);

  factory FlightEntry.forNew({
    @required Map<String, dynamic> data,
  }) {
    return FlightEntry(id: _generateRandomId(), data: data);
  }

  @override
  List<Object> get props => [id]; // idが等しければデータの中身までは見ない

  static String _generateRandomId() {
    const randomChars =
        'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    const charsLength = randomChars.length;
    const prefix = 'forNew:';
    const prefixLength = prefix.length;
    const int idLength = prefixLength + 20;

    final rand = new Random();
    final codeUnits = new List.generate(
      idLength,
      (index) {
        if (index < prefixLength) {
          return prefix.codeUnitAt(index);
        }
        final n = rand.nextInt(charsLength);
        return randomChars.codeUnitAt(n);
      },
    );
    return String.fromCharCodes(codeUnits);
  }
}
