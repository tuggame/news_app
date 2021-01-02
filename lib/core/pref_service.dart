import 'package:shared_preferences/shared_preferences.dart';

class PreferenceService {
  final String _themeKey = 'theme';

  final SharedPreferences _sharedPreferences;

  const PreferenceService(this._sharedPreferences);

  set useDarkMode(bool value) {
    _sharedPreferences.setBool(_themeKey, value);
  }

  bool get useDarkMode => _sharedPreferences.getBool(_themeKey) ?? false;
}
