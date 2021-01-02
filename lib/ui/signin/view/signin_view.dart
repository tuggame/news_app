import 'package:flutter/material.dart';
import 'package:news_app/const_lib/tr_consts.dart' as turkish;
import 'package:news_app/core/base_view.dart';
import 'package:news_app/network/firebase_helper.dart';
import 'package:news_app/ui/component/already_have_an_account_acheck.dart';
import 'package:news_app/ui/component/backgrounds.dart';
import 'package:news_app/ui/component/rounded_button.dart';
import 'package:news_app/ui/component/rounded_input_field.dart';
import 'package:news_app/ui/component/rounded_password_field.dart';
import 'package:news_app/ui/signin/view_model/signin_view_model.dart';

class SignInView extends StatefulWidget {
  @override
  _SignInViewState createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  SignInViewModel viewModel;
  @override
  Widget build(BuildContext context) {
    return BaseView<SignInViewModel>(
      onModelReady: (model) {
        model.init();
        model.setContext(context);
        viewModel = model;
      },
      builder: (context, value) => buildScaffold,
      model: SignInViewModel(),
    );
  }

  Scaffold get buildScaffold {
    return Scaffold(
      body: buildSignInForm,
    );
  }

  Widget get buildSignInForm {
    return Background2(
      child: SingleChildScrollView(
        child: Form(
          key: viewModel.formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                turkish.signIn,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: viewModel.size.height * 0.03),
              Image.asset(
                "assets/login538.png",
                height: viewModel.size.height * 0.35,
              ),
              SizedBox(height: viewModel.size.height * 0.03),
              RoundedInputField(
                icon: Icons.person,
                hintText: turkish.email,
                controller: viewModel.emailController,
                validator: (String value) {
                  if (value.trim().isEmpty) {
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
                text: turkish.signIn,
                color: Theme.of(context).colorScheme.primaryVariant,
                textColor: Colors.black,
                press: () async {
                  if (viewModel.formKey.currentState.validate()) {
                    FirebaseHelper.helperInstance.signIn(
                        context, viewModel.emailController.text.trim(), viewModel.passwordController.text.trim());
                  }
                },
              ),
              SizedBox(height: viewModel.size.height * 0.03),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    turkish.forget_password,
                    //style: TextStyle(color: kPrimaryColor),
                  ),
                  GestureDetector(
                    onTap: () async {
                      FirebaseHelper.helperInstance
                          .sendResetPasswordMail(context, viewModel.emailController.text.trim());
                    },
                    child: Text(
                      turkish.forget_password_mail,
                      style: Theme.of(context).textTheme.button,
                    ),
                  )
                ],
              ),
              SizedBox(height: viewModel.size.height * 0.03),
              AlreadyHaveAnAccountCheck(
                press: () {
                  Navigator.pushReplacementNamed(
                    context,
                    '/signup',
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
