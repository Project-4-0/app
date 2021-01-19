import 'package:b_one_project_4_0/widgets/BottomAppBarBOne.dart';
import 'package:b_one_project_4_0/widgets/FlatButtonBOne.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Container(
        child: Stack(
          children: [
            ClipPath(
              // clipper: CloudTopLeftClipper(),
              child: Container(
                color: Theme.of(context).primaryColorLight,
              ),
            ),
            SafeArea(
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      RichText(
                        text: TextSpan(
                          text: '',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 50,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Poppins',
                          ),
                          children: [
                            TextSpan(
                              text: 'B',
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor),
                            ),
                            TextSpan(
                              text: ' One',
                              style: TextStyle(
                                color: Theme.of(context).accentColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: Icon(
                          Icons.camera_alt,
                          color:
                              Theme.of(context).indicatorColor.withOpacity(0.4),
                          size: 300,
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        child: FlatButtonBOne(
                          onPressed: () {
                            Navigator.pushNamedAndRemoveUntil(
                                context, '/scanProduct', (route) => false);
                          },
                          text: "Starten",
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButtonBOne(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBarBOne(),
    );
  }
}
