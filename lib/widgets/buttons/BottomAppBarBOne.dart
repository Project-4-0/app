import 'package:flutter/material.dart';

// Navigation bar widget
class BottomAppBarBOne extends StatelessWidget {
  const BottomAppBarBOne({
    Key key,
    @required this.active,
  }) : super(key: key);

  final int active;

  @override
  Widget build(BuildContext context) {
return BottomAppBar(
      elevation: 50,
      notchMargin: 15.0,
      shape: CircularNotchedRectangle(),
      child: Container(
        height: 70,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // Home buttton
            FlatButton(
              onPressed: () {
                // Go to the general dashboard. This wil route you to the correct user type dashboard!
                Navigator.pushNamedAndRemoveUntil(
                    context, '/dashboard', (route) => false);
              },
              child: Icon(
                Icons.home,
                size: 30,
                color: active == 1
                    ? Theme.of(context).primaryColor
                    : Theme.of(context).accentColor,
              ),
            ),
            // Account buttton
            FlatButton(
              onPressed: () {
                Navigator.pushNamed(context, '/profile');
              },
              child: Padding(
                // padding: const EdgeInsets.only(right: 60),
                padding: const EdgeInsets.only(right: 30),
                child: Icon(
                  Icons.account_circle,
                  size: 30,
                  color: active == 2
                      ? Theme.of(context).primaryColor
                      : Theme.of(context).accentColor,
                ),
              ),
            ),
            // Info button
            FlatButton(
              onPressed: () {
                Navigator.pushNamed(context, '/info');
              },
              child: Padding(
                // padding: const EdgeInsets.only(left: 60),
                padding: const EdgeInsets.only(left: 30),
                child: Icon(
                  Icons.info,
                  size: 30,
                  color: active == 3
                      ? Theme.of(context).primaryColor
                      : Theme.of(context).accentColor,
                ),
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
                size: 30,
                color: active == 4
                    ? Theme.of(context).primaryColor
                    : Theme.of(context).accentColor,
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
                          Navigator.pushNamedAndRemoveUntil(
                    context, '/info', (route) => false);
        },
      ),
    );
  }
}
