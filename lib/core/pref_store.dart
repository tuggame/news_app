import 'package:mobx/mobx.dart';
import 'package:news_app/core/pref_service.dart';

part 'pref_store.g.dart';

class PrefStore = _PrefStore with _$PrefStore;

abstract class _PrefStore with Store {
  PreferenceService _preferenceService;

  _PrefStore(this._preferenceService) {
    _useDarkMode = _preferenceService.useDarkMode;
  }

  @observable
  bool _useDarkMode;

  @computed
  bool get darkMode => _useDarkMode;

  @action
  setDarkMode(bool value) {
    _preferenceService.useDarkMode = value;
    _useDarkMode = value;
  }
}
