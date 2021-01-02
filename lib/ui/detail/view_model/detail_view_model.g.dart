// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detail_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$DetailViewModel on _DetailViewModelBase, Store {
  final _$articleAtom = Atom(name: '_DetailViewModelBase.article');

  @override
  Article get article {
    _$articleAtom.reportRead();
    return super.article;
  }

  @override
  set article(Article value) {
    _$articleAtom.reportWrite(value, super.article, () {
      super.article = value;
    });
  }

  final _$errorAtom = Atom(name: '_DetailViewModelBase.error');

  @override
  bool get error {
    _$errorAtom.reportRead();
    return super.error;
  }

  @override
  set error(bool value) {
    _$errorAtom.reportWrite(value, super.error, () {
      super.error = value;
    });
  }

  final _$_DetailViewModelBaseActionController =
      ActionController(name: '_DetailViewModelBase');

  @override
  void failedWebview() {
    final _$actionInfo = _$_DetailViewModelBaseActionController.startAction(
        name: '_DetailViewModelBase.failedWebview');
    try {
      return super.failedWebview();
    } finally {
      _$_DetailViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
article: ${article},
error: ${error}
    ''';
  }
}
