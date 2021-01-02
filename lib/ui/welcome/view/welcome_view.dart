import 'package:flutter/material.dart';
import 'package:news_app/const_lib/tr_consts.dart' as turkish;
import 'package:news_app/ui/component/backgrounds.dart';
import 'package:news_app/ui/component/rounded_button.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return buildWelcomeView;
  }

  Widget get buildWelcomeView {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Background3(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: size.height * 0.05),
              Text(
                turkish.welcome,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20.0,
              ),
              Image.asset(
                "assets/app_icon538.png",
                height: size.height * 0.4,
              ),
              SizedBox(height: size.height * 0.05),
              RoundedButton(
                color: Theme.of(context).colorScheme.primaryVariant,
                text: turkish.signIn,
                textColor: Colors.black,
                press: () {
                  Navigator.pushNamed(
                    context,
                    '/signin',
                  );
                },
              ),
              RoundedButton(
                text: turkish.signUp,
                color: Theme.of(context).colorScheme.secondary,
                textColor: Colors.black,
                press: () {
                  Navigator.pushNamed(
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
