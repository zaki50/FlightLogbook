import 'package:equatable/equatable.dart';

abstract class SettingsState extends Equatable {
  final List _props;

  SettingsState([this._props]);

  @override
  List<Object> get props => _props;
}

class SettingsInitial extends SettingsState {
  SettingsInitial();

  @override
  String toString() => 'SettingsInitial';
}

class LoadingSettings extends SettingsState {
  LoadingSettings();

  @override
  String toString() => 'LoadingSettings';
}

class LoadSettingsSuccess extends SettingsState {
  final Map<String, Object> settings;

  LoadSettingsSuccess(this.settings) : super([settings]);

  @override
  String toString() => 'LoadSettingsSuccess';
}

class LoadSettingsFailure extends SettingsState {
  LoadSettingsFailure();

  @override
  String toString() => 'LoadSettingsFailure';
}

class UpdatingStringSetting extends SettingsState {
  final String key;
  final String value;
  UpdatingStringSetting(this.key, this.value) : super([key, value]);

  @override
  String toString() => 'UpdatingStringSetting';
}

class UpdatingIntSetting extends SettingsState {
  final String key;
  final int value;
  UpdatingIntSetting(this.key, this.value) : super([key, value]);

  @override
  String toString() => 'UpdatingIntSetting';
}

class UpdateSettingSuccess extends SettingsState {
  final String key;
  final Map<String, Object> settings;

  UpdateSettingSuccess(this.key, this.settings) : super([key, settings]);

  @override
  String toString() => 'UpdateSettingSuccess';
}

class UpdateSettingFailure extends SettingsState {
  final String key;

  UpdateSettingFailure(this.key) : super([key]);

  @override
  String toString() => 'UpdateSettingFailure';
}
