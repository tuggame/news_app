import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:news_app/const_lib/tr_consts.dart';
import 'package:news_app/core/base_view_model.dart';
import 'package:news_app/model/article.dart';
import 'package:news_app/network/newscast_api.dart';

part 'home_view_model.g.dart';

class HomeViewModel = _HomeViewModelBase with _$HomeViewModel;

abstract class _HomeViewModelBase with Store, BaseViewModel {
  TextEditingController searchController;

  @observable
  String keyword = "";

  @observable
  NewsCategory category = NewsCategory.general;

  @observable
  List<Article> articles = [];

  @observable
  bool loadingArticles = false;

  @observable
  List<Article> carouselArticles = [];

  @observable
  bool loadingCarouselArticles = true;

  @observable
  int carouselIndex = 0;

  @observable
  String error = "";

  @override
  void setContext(BuildContext context) {
    this.context = context;
  }

  @override
  init() async {
    loadArticles();
    searchController = TextEditingController();
  }

  @action
  Future<void> loadArticles([String keyword, NewsCategory category]) async {
    if (loadingArticles) {
      return;
    }
    await Future.delayed(Duration(microseconds: 1));
    loadingArticles = true;
    error = "";

    if (this.keyword != keyword) {
      this.articles = [];
      this.keyword = keyword;
      this.category = NewsCategory.general;
    } else if (this.category != category) {
      this.articles = [];
      this.category = category;
      keyword = "";
      searchController.clear();
    }

    try {
      if (category != null) {
        List<Article> list = await NewscastService.getNews(category: category);
        if (list != null) {
          articles.addAll(list);
        }
      } else if (keyword == null || keyword.isEmpty) {
        List<Article> list = await NewscastService.getNews();
        if (list != null) {
          articles.addAll(list);
          carouselArticles = articles.sublist(0, articles.length > 5 ? 5 : articles.length);
        }
      } else {
        List<Article> list = await NewscastService.getSearchResults(searchTxt: keyword);
        if (list != null) {
          articles.addAll(list);
        }
      }
    } catch (e) {
      this.error = something_wrongs;
    } finally {
      loadingArticles = false;
      loadingCarouselArticles = false;
    }
  }

  @action
  void resetArticles() {
    keyword = "";
    searchController.clear();
    articles = [];
    loadArticles();
  }

  @action
  void changeCarouselIndex(int index) {
    carouselIndex = index;
  }
}
