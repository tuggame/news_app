import 'package:flutter/material.dart';
import 'package:news_app/const_lib/tr_consts.dart' as turkish;
import 'package:news_app/core/base_view.dart';
import 'package:news_app/network/firebase_helper.dart';
import 'package:news_app/ui/component/already_have_an_account_acheck.dart';
import 'package:news_app/ui/component/backgrounds.dart';
import 'package:news_app/ui/component/divider.dart';
import 'package:news_app/ui/component/rounded_button.dart';
import 'package:news_app/ui/component/rounded_input_field.dart';
import 'package:news_app/ui/component/rounded_password_field.dart';
import 'package:news_app/ui/component/social_icon.dart';
import 'package:news_app/ui/signup/view_model/signup_view_model.dart';

class SignUpView extends StatefulWidget {
  @override
  _SignUpViewState createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  SignUpViewModel viewModel;
  @override
  Widget build(BuildContext context) {
    return BaseView<SignUpViewModel>(
      onModelReady: (model) {
        model.init();
        model.setContext(context);
        viewModel = model;
      },
      builder: (context, value) => buildScaffold,
      model: SignUpViewModel(),
    );
  }

  Scaffold get buildScaffold {
    return Scaffold(
      body: buildSignInForm,
    );
  }

  Widget get buildSignInForm {
    return Background1(
      child: SingleChildScrollView(
        child: Form(
          key: viewModel.formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                turkish.signUp,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: viewModel.size.height * 0.03),
              Image.asset(
                "assets/welcome538.png",
                height: viewModel.size.height * 0.35,
              ),
              RoundedInputField(
                icon: Icons.person,
                hintText: turkish.email,
                controller: viewModel.emailController,
                validator: (String value) {
                  if (value.trim().isEmpty || !FirebaseHelper.helperInstance.validateEmail(value.trim())) {
                    return turkish.invalid_email;
                  }
                  return null;
                },
              ),
              RoundedPasswordField(
                controller: viewModel.passwordController,
                validator: (String value) {
                  if (value.trim().isEmpty && value.trim().length < 6) {
                    return turkish.invalid_password;
                  }
                  return null;
                },
              ),
              RoundedButton(
                text: turkish.signUp,
                color: Theme.of(context).colorScheme.primaryVariant,
                textColor: Colors.black,
                press: () async {
                  if (viewModel.formKey.currentState.validate()) {
                    FirebaseHelper.helperInstance.signUp(
                        context, viewModel.emailController.text.trim(), viewModel.passwordController.text.trim());
                  }
                },
              ),
              SizedBox(height: viewModel.size.height * 0.03),
              AlreadyHaveAnAccountCheck(
                login: false,
                press: () {
                  Navigator.pushReplacementNamed(
                    context,
                    '/signin',
                  );
                },
              ),
              OrDivider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SocialIcon(
                    iconSrc: "assets/svg/google.svg",
                    press: () async {
                      FirebaseHelper.helperInstance.signInWithGoogle(context);
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
