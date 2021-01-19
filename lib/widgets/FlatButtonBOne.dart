import 'package:flutter/material.dart';

// Default design button BOne
class FlatButtonBOne extends StatelessWidget {
  const FlatButtonBOne({
    Key key,
    @required this.text,
    @required this.onPressed(),
    this.isActive,
    this.color,
  }) : super(key: key);

  final String text;
  final Color color;
  final bool isActive;
  final GestureTapCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: onPressed,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      minWidth: 160,
      height: 50,
      disabledColor: Theme.of(context).accentColor,
      disabledTextColor: Colors.white,
      color: Theme.of(context).buttonColor,
      child: Text(text),
    );
  }
}
