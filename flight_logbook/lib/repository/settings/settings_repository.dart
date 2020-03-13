import 'package:prefs_config/prefs_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class SettingsRepository {
  static const String KEY_COLOR_SCHEME = 'setting:color_scheme';
  static const int TYPE_COLOR_SCHEME = Pref.TYPE_LIST;
  static const int VALUE_COLOR_SCHEME_ANA = 0;
  static const int VALUE_COLOR_SCHEME_JAL = 1;
  static const int DEFAULT_VALUE_COLOR_SCHEME = VALUE_COLOR_SCHEME_ANA;

  static const Map<String, int> KEY_TO_TYPE = const {
    KEY_COLOR_SCHEME: TYPE_COLOR_SCHEME,
  };

  static const Map<String, Object> KEY_TO_DEFAULT_VALUE = const {
    KEY_COLOR_SCHEME: VALUE_COLOR_SCHEME_ANA,
  };

  Future<Map<String, Object>> getAllSettings();

  Future<MapEntry<String, String>> updateStringSetting(
    String key,
    String value,
  );
  Future<MapEntry<String, int>> updateIntSetting(
    String key,
    int value,
  );

  Future<String> getStringSetting(String key);
  Future<int> getIntSetting(String key);
}

class SharedPrefSettingsRepository extends SettingsRepository {
  SharedPreferences _sharedPrefs;

  SharedPrefSettingsRepository();

  @override
  Future<Map<String, Object>> getAllSettings() async {
    if (_sharedPrefs == null) {
      _sharedPrefs = await SharedPreferences.getInstance();
    }

    final Map<String, Object> settings =
        Map.from(SettingsRepository.KEY_TO_DEFAULT_VALUE);
    _sharedPrefs.getKeys().forEach((key) {
      final type = SettingsRepository.KEY_TO_TYPE[key];
      if (type == null) {
        return;
      }
      switch (type) {
        case Pref.TYPE_TEXT:
          settings[key] = _sharedPrefs.getString(key);
          break;
        case Pref.TYPE_LIST:
        case Pref.TYPE_INT:
          settings[key] = _sharedPrefs.getInt(key);
          break;
        default:
          settings[key] = _sharedPrefs.get(key);
          break;
      }
    });
    return settings;
  }

  @override
  Future<MapEntry<String, String>> updateStringSetting(
      String key, String value) async {
    _checkTypeValid(key, expected: const [Pref.TYPE_TEXT]);

    if (_sharedPrefs == null) {
      _sharedPrefs = await SharedPreferences.getInstance();
    }

    _sharedPrefs.setString(key, value);
    return MapEntry(key, value);
  }

  @override
  Future<MapEntry<String, int>> updateIntSetting(String key, int value) async {
    _checkTypeValid(key, expected: const [Pref.TYPE_INT, Pref.TYPE_LIST]);

    if (_sharedPrefs == null) {
      _sharedPrefs = await SharedPreferences.getInstance();
    }

    _sharedPrefs.setInt(key, value);
    return MapEntry(key, value);
  }

  @override
  Future<String> getStringSetting(String key) async {
    _checkTypeValid(key, expected: const [Pref.TYPE_TEXT]);

    if (_sharedPrefs == null) {
      _sharedPrefs = await SharedPreferences.getInstance();
    }

    return _sharedPrefs.getString(key) ??
        SettingsRepository.KEY_TO_DEFAULT_VALUE[key];
  }

  @override
  Future<int> getIntSetting(String key) async {
    _checkTypeValid(key, expected: const [Pref.TYPE_INT, Pref.TYPE_LIST]);

    if (_sharedPrefs == null) {
      _sharedPrefs = await SharedPreferences.getInstance();
    }

    return _sharedPrefs.getString(key) ??
        SettingsRepository.KEY_TO_DEFAULT_VALUE[key];
  }

  void _checkTypeValid(String key, {List<int> expected}) {
    final int type = SettingsRepository.KEY_TO_TYPE[key];
    if (!expected.contains(type)) {
      throw Exception("wrong method is called against ${key}.");
    }
  }
}
