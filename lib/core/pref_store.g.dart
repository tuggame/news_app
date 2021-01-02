// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pref_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$PrefStore on _PrefStore, Store {
  Computed<bool> _$darkModeComputed;

  @override
  bool get darkMode => (_$darkModeComputed ??=
          Computed<bool>(() => super.darkMode, name: '_PrefStore.darkMode'))
      .value;

  final _$_useDarkModeAtom = Atom(name: '_PrefStore._useDarkMode');

  @override
  bool get _useDarkMode {
    _$_useDarkModeAtom.reportRead();
    return super._useDarkMode;
  }

  @override
  set _useDarkMode(bool value) {
    _$_useDarkModeAtom.reportWrite(value, super._useDarkMode, () {
      super._useDarkMode = value;
    });
  }

  final _$_PrefStoreActionController = ActionController(name: '_PrefStore');

  @override
  dynamic setDarkMode(bool value) {
    final _$actionInfo = _$_PrefStoreActionController.startAction(
        name: '_PrefStore.setDarkMode');
    try {
      return super.setDarkMode(value);
    } finally {
      _$_PrefStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
darkMode: ${darkMode}
    ''';
  }
}
