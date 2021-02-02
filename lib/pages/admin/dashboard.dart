import 'package:b_one_project_4_0/widgets/SafeAreaBOne/safeAreaBOne.dart';
import 'package:b_one_project_4_0/widgets/buttons/BottomAppBarBOne.dart';
import 'package:b_one_project_4_0/widgets/buttons/DashboardButtonsOverview.dart';
import 'package:flutter/material.dart';
import 'package:b_one_project_4_0/widgets/TimeSeriesChart.dart';

class AdminDashboardPage extends StatefulWidget {
  @override
  _AdminDashboardPageState createState() => _AdminDashboardPageState();
}

class _AdminDashboardPageState extends State<AdminDashboardPage> {
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
                  padding: safeAreaBOne(),
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
                        // First row of dashboard buttons
                        Container(
                          width: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: DashboardButtonsOverview(
                                  text: "Gebruikers",
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context, '/admin/users');
                                    print("Go to user overview");
                                  },
                                  icon: Icons.group,
                                ),
                              ),
                              Padding(padding: EdgeInsets.all(5.0)),
                              Expanded(
                                child: DashboardButtonsOverview(
                                  text: "Boxen",
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context, '/admin/boxen');
                                    print("Go to box overview");
                                  },
                                  icon: Icons.widgets,
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(padding: EdgeInsets.all(5.0)),
                        // Seccond row of dashboard buttons
                        Container(
                          width: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: DashboardButtonsOverview(
                                  text: "Koppelen",
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context, '/monteur/connected');
                                    print("Go to connect box with user");
                                  },
                                  icon: Icons.link,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(padding: EdgeInsets.all(15.0)),
                        // Light sensor
                        SizedBox(
                          width: double.infinity,
                          height: 250.0,
                          child: TimeSeriesChart.withSampleData(
                            title: "Lichthoeveelheid gem.",
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
                              title: "Temperatuur gem.",
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
      bottomNavigationBar: BottomAppBarBOne(
        active: 1,
      ),
    );
  }
}
