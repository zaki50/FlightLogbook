import 'package:equatable/equatable.dart';

abstract class SettingsEvent extends Equatable {
  final List _props;

  SettingsEvent([this._props]);

  @override
  List<Object> get props => _props;
}

class LoadAllSettings extends SettingsEvent {
  LoadAllSettings();

  @override
  String toString() => 'LoadAllSettings';
}

class UpdateStringSetting extends SettingsEvent {
  final String key;
  final String value;
  UpdateStringSetting(this.key, this.value) : super([key, value]);

  @override
  String toString() => 'UpdateStringSetting';
}

class UpdateIntSetting extends SettingsEvent {
  final String key;
  final int value;
  UpdateIntSetting(this.key, this.value) : super([key, value]);

  @override
  String toString() => 'UpdateIntSetting';
}
