import 'package:flutter/material.dart';
import 'package:news_app/const_lib/tr_consts.dart' as turkish;
import 'package:news_app/ui/component/text_field_container.dart';

class RoundedPasswordField extends StatefulWidget {
  final ValueChanged<String> onChanged;
  final TextEditingController controller;
  final validator;

  const RoundedPasswordField({
    Key key,
    this.onChanged,
    this.controller,
    this.validator,
  }) : super(key: key);

  @override
  _RoundedPasswordFieldState createState() => _RoundedPasswordFieldState();
}

class _RoundedPasswordFieldState extends State<RoundedPasswordField> {
  bool _isHidden = true;

  void _toggleVisibility() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextFormField(
        obscureText: _isHidden,
        controller: widget.controller,
        validator: widget.validator,
        onChanged: widget.onChanged,
        cursorColor: Theme.of(context).colorScheme.primary,
        decoration: InputDecoration(
          hintText: turkish.password,
          hintStyle: TextStyle(color: Colors.black38),
          icon: Icon(
            Icons.lock,
            color: Theme.of(context).colorScheme.primary,
          ),
          suffixIcon: IconButton(
            icon: Icon(
              _isHidden ? Icons.visibility : Icons.visibility_off,
              color: Theme.of(context).colorScheme.primary,
            ),
            onPressed: _toggleVisibility,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
