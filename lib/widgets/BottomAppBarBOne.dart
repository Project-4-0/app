import 'package:flutter/material.dart';

//Navigation bar widget
class BottomAppBarBOne extends StatelessWidget {
  const BottomAppBarBOne({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      elevation: 50,
      notchMargin: 15.0,
      shape: CircularNotchedRectangle(),
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            // Home buttton
            FlatButton(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, '/home', (route) => false);
              },
              child: Icon(
                Icons.home,
                color: Theme.of(context).accentColor,
              ),
            ),
            // Account buttton
            FlatButton(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, '/profile', (route) => false);
              },
              child: Icon(
                Icons.account_circle,
                color: Theme.of(context).accentColor,
              ),
            ),
            // Info button
            FlatButton(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, '/info', (route) => false);
              },
              child: Icon(
                Icons.info,
                color: Theme.of(context).accentColor,
              ),
            ),
            // Logout button
            FlatButton(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, '/login', (route) => false);
              },
              child: Icon(
                Icons.exit_to_app,
                color: Theme.of(context).accentColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FloatingActionButtonBOne extends StatelessWidget {
  const FloatingActionButtonBOne({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 140,
      child: FloatingActionButton(
        child: Padding(
          padding: EdgeInsets.all(3.0),
          child: Image(
            image: AssetImage("assets/logo_vito_colorful.png"),
          ),
        ),
        backgroundColor: Colors.white,
        onPressed: () {
          Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
        },
      ),
    );
  }
}
