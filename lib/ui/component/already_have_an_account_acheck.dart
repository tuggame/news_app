import 'package:flutter/material.dart';
import 'package:news_app/const_lib/tr_consts.dart' as turkish;

class AlreadyHaveAnAccountCheck extends StatelessWidget {
  final bool login;
  final Function press;
  const AlreadyHaveAnAccountCheck({
    Key key,
    this.login = true,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          login ? turkish.do_not_have_account : turkish.already_have_account,
          //style: TextStyle(color: kPrimaryColor),
        ),
        GestureDetector(
          onTap: press,
          child: Text(
            login ? turkish.signUp_Lower : turkish.signIn_Lower,
            style: Theme.of(context).textTheme.button,
            /*
            style: TextStyle(
              color: kPrimaryColor,
              fontWeight: FontWeight.bold,
            ),

             */
          ),
        )
      ],
    );
  }
}
