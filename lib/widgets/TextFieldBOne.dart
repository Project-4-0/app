import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Default Textield button Gshop
class TextFieldBOne extends StatelessWidget {
  const TextFieldBOne({
    Key key,
    @required this.context,
    @required this.labelText,
    this.controller,
    this.icon,
    this.validator,
    this.maxLength,
    this.onSave,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
  }) : super(key: key);

  final String labelText;
  final Icon icon;
  final TextEditingController controller;
  final BuildContext context;
  final int maxLength;
  final Function validator;
  final Function onSave;
  final TextInputType keyboardType;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      maxLength: maxLength,
      onSaved: onSave,
      controller: controller,
      validator: validator,
      autofocus: false,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        focusColor: Theme.of(context).accentColor,
        hoverColor: Theme.of(context).accentColor,
        filled: true,
        fillColor: Colors.white,
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(30),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(30),
        ),
        //error
        errorBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(30),
        ),
        focusedErrorBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
          borderRadius: BorderRadius.circular(30),
        ),
        counterStyle: TextStyle(
          fontSize: 12,
          height: 0.7,
        ),
        errorMaxLines: 3,
        labelText: this.labelText,
        prefixIcon: this.icon,
      ),
    );
  }
}
