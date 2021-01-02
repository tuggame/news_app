import 'package:flutter/material.dart';

class RoundedOutlineButton extends StatelessWidget {
  final String text;
  final Function onPressed;
  final Color borderColor, textColor;
  const RoundedOutlineButton({
    Key key,
    this.text,
    this.onPressed,
    this.borderColor,
    this.textColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      minWidth: 15.0,
      child: OutlineButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
            color: textColor,
          ),
        ),
        shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(10.0),
        ),
        borderSide: BorderSide(
          color: borderColor,
          style: BorderStyle.solid,
          width: 1,
        ),
      ),
    );
  }
}
