import 'package:flutter/material.dart';

// Default design button BOne
class IconTextLeftButton extends StatelessWidget {
  const IconTextLeftButton({
    Key key,
    @required this.text,
    @required this.onPressed(),
    @required this.icons,
    this.isActive,
    this.color,
  }) : super(key: key);

  final String text;
  final Color color;
  final IconData icons;
  final bool isActive;
  final GestureTapCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: onPressed,
      child: Row(children: [
        Icon(
          icons,
          color: color,
        ),
        Padding(padding: EdgeInsets.only(left: 5)),
        Text(
          text,
          style: TextStyle(
            color: color,
          ),
        ),
      ]),
    );
  }
}
