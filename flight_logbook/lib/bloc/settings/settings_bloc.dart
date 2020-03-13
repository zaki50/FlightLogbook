import 'package:flightlogbook/bloc/settings/settings_event.dart';
import 'package:flightlogbook/bloc/settings/settings_state.dart';
import 'package:flightlogbook/repository/settings/settings_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final SettingsRepository _repository;

  SettingsBloc({
    @required SettingsRepository repository,
  })  : assert(repository != null),
        _repository = repository;

  @override
  SettingsState get initialState => SettingsInitial();

  @override
  Stream<SettingsState> mapEventToState(SettingsEvent event) async* {
    if (event is LoadAllSettings) {
      yield* _mapLoadAllSettingsToState(event);
    } else if (event is UpdateStringSetting) {
      yield* _mapUpdateStringSettingToState(event);
    } else if (event is UpdateIntSetting) {
      yield* _mapUpdateIntSettingToState(event);
    }
  }

  Stream<SettingsState> _mapLoadAllSettingsToState(
      LoadAllSettings event) async* {
    yield LoadingSettings();
    try {
      final Map<String, Object> allSettings =
          await _repository.getAllSettings();
      yield LoadSettingsSuccess(Map.unmodifiable(allSettings));
    } catch (_) {
      yield LoadSettingsFailure();
    }
  }

  Stream<SettingsState> _mapUpdateStringSettingToState(
      UpdateStringSetting event) async* {
    yield UpdatingStringSetting(event.key, event.value);
    try {
      await _repository.updateStringSetting(event.key, event.value);
      yield UpdateSettingSuccess(event.key, await _repository.getAllSettings());
    } catch (_) {
      yield UpdateSettingFailure(event.key);
    }
  }

  Stream<SettingsState> _mapUpdateIntSettingToState(
      UpdateIntSetting event) async* {
    yield UpdatingIntSetting(event.key, event.value);
    try {
      await _repository.updateIntSetting(event.key, event.value);
      yield UpdateSettingSuccess(event.key, await _repository.getAllSettings());
    } catch (_) {
      yield UpdateSettingFailure(event.key);
    }
  }
}
