// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HomeViewModel on _HomeViewModelBase, Store {
  final _$keywordAtom = Atom(name: '_HomeViewModelBase.keyword');

  @override
  String get keyword {
    _$keywordAtom.reportRead();
    return super.keyword;
  }

  @override
  set keyword(String value) {
    _$keywordAtom.reportWrite(value, super.keyword, () {
      super.keyword = value;
    });
  }

  final _$categoryAtom = Atom(name: '_HomeViewModelBase.category');

  @override
  NewsCategory get category {
    _$categoryAtom.reportRead();
    return super.category;
  }

  @override
  set category(NewsCategory value) {
    _$categoryAtom.reportWrite(value, super.category, () {
      super.category = value;
    });
  }

  final _$articlesAtom = Atom(name: '_HomeViewModelBase.articles');

  @override
  List<Article> get articles {
    _$articlesAtom.reportRead();
    return super.articles;
  }

  @override
  set articles(List<Article> value) {
    _$articlesAtom.reportWrite(value, super.articles, () {
      super.articles = value;
    });
  }

  final _$loadingArticlesAtom =
      Atom(name: '_HomeViewModelBase.loadingArticles');

  @override
  bool get loadingArticles {
    _$loadingArticlesAtom.reportRead();
    return super.loadingArticles;
  }

  @override
  set loadingArticles(bool value) {
    _$loadingArticlesAtom.reportWrite(value, super.loadingArticles, () {
      super.loadingArticles = value;
    });
  }

  final _$carouselArticlesAtom =
      Atom(name: '_HomeViewModelBase.carouselArticles');

  @override
  List<Article> get carouselArticles {
    _$carouselArticlesAtom.reportRead();
    return super.carouselArticles;
  }

  @override
  set carouselArticles(List<Article> value) {
    _$carouselArticlesAtom.reportWrite(value, super.carouselArticles, () {
      super.carouselArticles = value;
    });
  }

  final _$loadingCarouselArticlesAtom =
      Atom(name: '_HomeViewModelBase.loadingCarouselArticles');

  @override
  bool get loadingCarouselArticles {
    _$loadingCarouselArticlesAtom.reportRead();
    return super.loadingCarouselArticles;
  }

  @override
  set loadingCarouselArticles(bool value) {
    _$loadingCarouselArticlesAtom
        .reportWrite(value, super.loadingCarouselArticles, () {
      super.loadingCarouselArticles = value;
    });
  }

  final _$carouselIndexAtom = Atom(name: '_HomeViewModelBase.carouselIndex');

  @override
  int get carouselIndex {
    _$carouselIndexAtom.reportRead();
    return super.carouselIndex;
  }

  @override
  set carouselIndex(int value) {
    _$carouselIndexAtom.reportWrite(value, super.carouselIndex, () {
      super.carouselIndex = value;
    });
  }

  final _$errorAtom = Atom(name: '_HomeViewModelBase.error');

  @override
  String get error {
    _$errorAtom.reportRead();
    return super.error;
  }

  @override
  set error(String value) {
    _$errorAtom.reportWrite(value, super.error, () {
      super.error = value;
    });
  }

  final _$loadArticlesAsyncAction =
      AsyncAction('_HomeViewModelBase.loadArticles');

  @override
  Future<void> loadArticles([String keyword, NewsCategory category]) {
    return _$loadArticlesAsyncAction
        .run(() => super.loadArticles(keyword, category));
  }

  final _$_HomeViewModelBaseActionController =
      ActionController(name: '_HomeViewModelBase');

  @override
  void resetArticles() {
    final _$actionInfo = _$_HomeViewModelBaseActionController.startAction(
        name: '_HomeViewModelBase.resetArticles');
    try {
      return super.resetArticles();
    } finally {
      _$_HomeViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeCarouselIndex(int index) {
    final _$actionInfo = _$_HomeViewModelBaseActionController.startAction(
        name: '_HomeViewModelBase.changeCarouselIndex');
    try {
      return super.changeCarouselIndex(index);
    } finally {
      _$_HomeViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
keyword: ${keyword},
category: ${category},
articles: ${articles},
loadingArticles: ${loadingArticles},
carouselArticles: ${carouselArticles},
loadingCarouselArticles: ${loadingCarouselArticles},
carouselIndex: ${carouselIndex},
error: ${error}
    ''';
  }
}
