import 'package:b_one_project_4_0/controller/kpiController.dart';
import 'package:b_one_project_4_0/models/kpi.dart';
import 'package:b_one_project_4_0/widgets/SafeAreaBOne/safeAreaBOne.dart';
import 'package:b_one_project_4_0/widgets/buttons/BottomAppBarBOne.dart';
import 'package:b_one_project_4_0/widgets/buttons/DashboardButtonsOverview.dart';
import 'package:b_one_project_4_0/widgets/charts/Kpi.dart';
import 'package:flutter/material.dart';

class AdminDashboardPage extends StatefulWidget {
  @override
  _AdminDashboardPageState createState() => _AdminDashboardPageState();
}

class _AdminDashboardPageState extends State<AdminDashboardPage> {
  Kpi kpi;

  @override
  void initState() {
    super.initState();
  }

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
                        KPI(),
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
