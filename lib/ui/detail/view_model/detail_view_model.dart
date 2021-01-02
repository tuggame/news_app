import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:news_app/core/base_view_model.dart';
import 'package:news_app/model/article.dart';

part 'detail_view_model.g.dart';

class DetailViewModel = _DetailViewModelBase with _$DetailViewModel;

abstract class _DetailViewModelBase with Store, BaseViewModel {
  @observable
  Article article;

  @observable
  bool error = false;

  @override
  void setContext(BuildContext context) {
    this.context = context;
    article = ModalRoute.of(context).settings.arguments;
  }

  @override
  init() async {}

  @action
  void failedWebview() {
    error = true;
  }
}
