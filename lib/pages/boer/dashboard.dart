import 'package:b_one_project_4_0/widgets/BottomAppBarBOne.dart';
import 'package:b_one_project_4_0/widgets/TextFieldBOne.dart';
import 'package:b_one_project_4_0/widgets/TopBarButtons.dart';
import 'package:flutter/material.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
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
                        Padding(padding: EdgeInsets.all(10.0)),
                        TopBarButtons(
                          onPressedLeft: () {
                            _filter(context);
                          },
                          onPressedRight: () {},
                          textLeft: "Filters",
                          textRight: "Box",
                          iconLeft: Icons.filter_list,
                          iconRight: Icons.business_center,
                          color: Colors.grey.shade900,
                        ),
                        //Botton
                        TextFieldBOne(context: context, labelText: "test"),
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

void _filter(context) {
  showModalBottomSheet(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(30),
      ),
    ),
    clipBehavior: Clip.antiAliasWithSaveLayer,
    backgroundColor: Colors.white,
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(builder: (BuildContext context,
          StateSetter setState /*You can rename this!*/) {
        return Container(
          height: 600,
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.all(25),
            child: Column(
              children: [
                Text(
                  "Filters",
                  style: Theme.of(context).textTheme.headline4,
                ),
                Text("okss"),
              ],
            ),
          ),
        );
      });
    },
  );
}
