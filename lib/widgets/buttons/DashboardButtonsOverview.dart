import 'package:flutter/material.dart';

// Default design button BOne
class DashboardButtonsOverview extends StatelessWidget {
  const DashboardButtonsOverview({
    Key key,
    @required this.text,
    @required this.icon,
    @required this.onPressed(),
    this.minWidth = 0,
  }) : super(key: key);

  final String text;
  final IconData icon;
  final GestureTapCallback onPressed;
  final double minWidth;

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      minWidth: this.minWidth,
      child: new RaisedButton(
        onPressed: onPressed,
        color: Theme.of(context).buttonColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        padding: EdgeInsets.all(25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              this.icon, // Icon from parent
              color: Colors.white,
              size: 40,
            ),
            Text(
              this.text,
              style: TextStyle(color: Colors.white, fontSize: 22.0)),
              // maxLines: 1,
              // overflow: TextOverflow.ellipsis,
            // ),
          ],
        ),
      ),
    );
  }
}
