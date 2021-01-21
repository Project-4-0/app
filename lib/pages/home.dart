import 'package:b_one_project_4_0/widgets/BottomAppBarBOne.dart';
import 'package:flutter/material.dart';
import 'package:b_one_project_4_0/widgets/SimpleLineChart.dart';
import 'package:b_one_project_4_0/widgets/TimeSeriesChart.dart';

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
                                      print("Go to user overview");
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
                                      print("Go to box overview");
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
                        // Light sensor
                        SizedBox(
                          width: double.infinity,
                          height: 250.0,
                          // child: TimeSeriesChart(title: "Luchtvochtigheid", animate: true),
                          child: TimeSeriesChart.withSampleData(
                            title: "Lichthoeveelheid",
                            animate: true,
                            unit: "%",
                            lineColor: Colors.green,
                            meassureAxisValues: [0, 25, 50, 75, 100],
                          ),
                        ),
                        // Temp sensor
                        SizedBox(
                          width: double.infinity,
                          height: 250.0,
                          // child: TimeSeriesChart(title: "Luchtvochtigheid", animate: true),
                          child: TimeSeriesChart.withSampleData(
                              title: "Temperatuur",
                              animate: true,
                              unit: "°C",
                              lineColor: Colors.red,
                              meassureAxisValues: [
                                -20,
                                -10,
                                0,
                                10,
                                20,
                                30,
                                40
                              ]),
                        ),
                        Padding(padding: EdgeInsets.all(15.0)),
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
