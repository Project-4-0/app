import 'package:flutter/material.dart';

// Default design button BOne
class DashboardButtonsOverview extends StatelessWidget {
  const DashboardButtonsOverview({
    Key key,
    @required this.text,
    @required this.icon,
    @required this.onPressed(),
  }) : super(key: key);

  final String text;
  final IconData icon;
  final GestureTapCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return new RaisedButton(
      onPressed: onPressed,
      color: Theme.of(context).buttonColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      padding: EdgeInsets.all(25.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(this.text,
              style: TextStyle(color: Colors.white, fontSize: 22.0)),
          Icon(
            this.icon, // Icon from parent
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
