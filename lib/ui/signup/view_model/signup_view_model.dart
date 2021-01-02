import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:news_app/core/base_view_model.dart';

part 'signup_view_model.g.dart';

class SignUpViewModel = _SignUpViewModelBase with _$SignUpViewModel;

abstract class _SignUpViewModelBase with Store, BaseViewModel {
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
