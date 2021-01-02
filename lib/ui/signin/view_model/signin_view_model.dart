import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:news_app/core/base_view_model.dart';

part 'signin_view_model.g.dart';

class SignInViewModel = _SignInViewModelBase with _$SignInViewModel;

abstract class _SignInViewModelBase with Store, BaseViewModel {
  GlobalKey<FormState> formKey;
  TextEditingController emailController;
  TextEditingController passwordController;
  Size size;

  @override
  void setContext(BuildContext context) {
    this.context = context;
    size = MediaQuery.of(context).size;
  }

  @override
  init() async {
    formKey = GlobalKey<FormState>();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }
}
