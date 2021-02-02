import 'package:flutter/material.dart';

// Default design button BOne
class OutlineFlatButtonBOne extends StatelessWidget {
  const OutlineFlatButtonBOne({
    Key key,
    @required this.text,
    @required this.onPressed(),
    this.isActive,
    this.color,
    this.icon,
  }) : super(key: key);

  final String text;
  final Color color;
  final bool isActive;
  final Icon icon;
  final GestureTapCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
        onPressed: onPressed,
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(
              color: onPressed != null
                  ? Theme.of(context).primaryColor
                  : Theme.of(context).accentColor),
        ),
        minWidth: 160,
        height: 40,
        disabledColor: Colors.white,
        disabledTextColor: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              text,
              style: TextStyle(
                color: onPressed != null
                    ? Theme.of(context).primaryColor
                    : Theme.of(context).accentColor,
              ),
            ),
            if (icon != null) Padding(padding: EdgeInsets.all(5.0)),
            if (icon != null) icon
          ],
        ));
  }
}
