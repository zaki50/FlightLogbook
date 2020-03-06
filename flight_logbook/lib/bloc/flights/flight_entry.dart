import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class FlightEntry extends Equatable {
  final String id;
  final Map<String, dynamic> data;

  static const FIELD_UID = 'uid'; // ユーザーのID
  static const FIELD_DEPARTURE_DATE = 'departure_date'; // 搭乗日
  static const FIELD_AIRLINE = 'airline'; // 航空会社
  static const FIELD_FLIGHT_NUMBER = 'flight_number'; // 便名
  static const FIELD_SERVICE_CLASS = 'service_class'; // 座席クラス
  static const FIELD_SEAT_NUMBER = 'seat_number'; // 座席番号
  static const FIELD_AIRCRAFT_TYPE = 'aricraft_type'; // 機種
  static const FIELD_AIRCRAFT_REGISTRATION = 'aricraft_registration'; // 機体記号
  static const FIELD_FROM = 'from'; // 出発空港
  static const FIELD_TO = 'to'; // 到着空港
  static const FIELD_DEPARTURE_GATE = 'departure_gate'; // 出発ゲート
  static const FIELD_ARRIVAL_GATE = 'arrival_gate'; // 到着ゲート
  static const FIELD_DEPARTURE_WEATHER = 'departure_weather'; // 出発空港の天候
  static const FIELD_ARRIVAL_WEATHER = 'arrival_weather'; // 到着空港の天候

  static const FIELD_SCHEDULED_DEPARTURE_TIME =
      'scheduled_departure_time'; // 出発予定時刻
  static const FIELD_SCHEDULED_ARRIVAL_TIME =
      'scheduled_arrival_time'; // 到着予定時刻
  static const FIELD_DEPARTURE_TIME = 'departure_time'; // 出発時刻
  static const FIELD_ARRIVAL_TIME = 'arrival_time'; // 到着時刻
  static const FIELD_TAKE_OFF_TIME = 'take_off_time'; // 離陸時刻
  static const FIELD_LANDING_TIME = 'landing_time'; // 着陸時刻
  static const FIELD_TAKE_OFF_RUNWAY = 'take_off_runway'; // 離陸時刻
  static const FIELD_LANDING_RUNWAY = 'landing_runway'; // 着陸時刻
  static const FIELD_MEMO = 'memo'; // メモ

  FlightEntry({
    @required this.id,
    @required this.data,
  })  : assert(id != null && id.isNotEmpty),
        assert(data != null);

  @override
  List<Object> get props => [id]; // idが等しければデータの中身までは見ない
}
