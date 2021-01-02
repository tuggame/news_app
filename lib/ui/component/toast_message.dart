import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class ToastMessage {
  final String text;
  const ToastMessage({
    this.text,
  });

  void showToastMessage(BuildContext context) {
    Toast.show(text, context,
        duration: Toast.LENGTH_SHORT,
        gravity: Toast.BOTTOM,
        textColor: Theme.of(context).buttonColor,
        backgroundColor: Theme.of(context).canvasColor);
  }
}
