import 'package:flutter/material.dart';
import 'package:news_app/ui/component/text_field_container.dart';

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final String initialText;
  final IconData icon;
  final Function clearButtonFunction;
  final ValueChanged<String> onChanged;
  final TextEditingController controller;
  final Function submitted;
  final validator;

  const RoundedInputField({
    Key key,
    this.hintText,
    this.icon,
    this.clearButtonFunction,
    this.onChanged,
    this.submitted,
    this.controller,
    this.validator,
    this.initialText = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextFormField(
        // initialValue: initialText,
        onChanged: onChanged,
        onFieldSubmitted: submitted,
        controller: controller,
        validator: validator,
        cursorColor: Theme.of(context).colorScheme.primary,
        decoration: icon != null
            ? InputDecoration(
                icon: Icon(
                  icon,
                  color: Theme.of(context).colorScheme.primary,
                ),
                hintText: hintText,
                hintStyle: TextStyle(color: Colors.black38),
                border: InputBorder.none,
                suffixIcon: IconButton(
                  onPressed: () => clearButtonFunction != null ? clearButtonFunction : controller.clear(),
                  icon: Icon(Icons.clear),
                ),
              )
            : InputDecoration(
                hintText: hintText,
                hintStyle: TextStyle(color: Colors.black38),
                border: InputBorder.none,
              ),
      ),
    );
  }
}
