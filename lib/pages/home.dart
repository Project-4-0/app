import 'package:b_one_project_4_0/widgets/buttons/BottomAppBarBOne.dart';
import 'package:b_one_project_4_0/widgets/buttons/FlatButtonBOne.dart';
import 'package:b_one_project_4_0/widgets/buttons/DashboardButtonsOverview.dart';
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
      body: SingleChildScrollView(
        child: Container(
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
                        Text(
                          'Dashboard',
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 50,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Poppins',
                          ),
                        ),
                        Padding(padding: EdgeInsets.all(15.0)),
                        Container(
                          width: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Users
                              Expanded(
                                child: RaisedButton(
                                    onPressed: () {
                                      Navigator.pushNamedAndRemoveUntil(
                                          context, '/users', (route) => false);
                                    },
                                    color: Theme.of(context).buttonColor,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0)),
                                    padding: EdgeInsets.all(25.0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text('Gebruikers',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 22.0)),
                                        Icon(
                                          Icons.group,
                                          color: Colors.white,
                                        ),
                                      ],
                                    )),
                              ),
                              SizedBox(
                                width: 10.0,
                              ),
                              // Boxen
                              Expanded(
                                child: RaisedButton(
                                    onPressed: () {
                                      Navigator.pushNamedAndRemoveUntil(
                                          context, '/boxen', (route) => false);
                                    },
                                    color: Theme.of(context).buttonColor,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0)),
                                    padding: EdgeInsets.fromLTRB(
                                        10.0, 25.0, 10.0, 25.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text('Boxen',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 22.0)),
                                        Icon(
                                          Icons.widgets,
                                          color: Colors.white,
                                        ),
                                      ],
                                    )),
                              ),
                            ],
                          ),
                        ),
                        Padding(padding: EdgeInsets.all(15.0)),
                        SizedBox(
                          width: 250.0,
                          height: 150.0,
                          child: const Card(child: Text('Graph!')),
                        ),
                        Padding(padding: EdgeInsets.all(15.0)),
                        SizedBox(
                          width: 250.0,
                          height: 150.0,
                          child: const Card(child: Text('Graph!')),
                        ),
                        Padding(padding: EdgeInsets.all(15.0)),
                        SizedBox(
                          width: 250.0,
                          height: 150.0,
                          child: const Card(child: Text('Sat!')),
                        ),
                        SizedBox(
                          width: 250.0,
                          height: 150.0,
                          child: const Card(child: Text('Graph!')),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButtonBOne(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBarBOne(),
    );
  }
}
