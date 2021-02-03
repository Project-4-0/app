import 'package:b_one_project_4_0/models/kpi.dart';
import 'package:b_one_project_4_0/models/box.dart';
import 'package:b_one_project_4_0/controller/boxController.dart';
import 'package:b_one_project_4_0/pages/admin/boxData.dart';
import 'package:b_one_project_4_0/widgets/SafeAreaBOne/safeAreaBOne.dart';
import 'package:b_one_project_4_0/widgets/TextFieldBOne.dart';
import 'package:b_one_project_4_0/widgets/BoxListItem.dart';
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

  List<Box> boxList = List<Box>();
  List<Box> originalBoxList = List<Box>();

  TextEditingController searchBoxController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getBoxes();
    searchBoxController.addListener(_searchBoxValueChanged);
  }

  void _getBoxes() {
    BoxController.loadBoxes().then((result) {
      setState(() {
        originalBoxList = result;
        originalBoxList.sort((a, b) {
          return a.name.toLowerCase().compareTo(b.name.toLowerCase());
        });
        boxList = originalBoxList; // Page loaded so list isn't filtered
      });
    });
  }

  void _searchBoxValueChanged() {
    print("Box search text field: ${searchBoxController.text}");
    setState(() {
      this.boxList = originalBoxList
          .where((box) => box.name
              .toLowerCase()
              .contains(searchBoxController.text.toLowerCase()))
          .toList();
      this.boxList.sort((a, b) {
        return a.name.toLowerCase().compareTo(b.name.toLowerCase());
      });
    });
    print("Filtered box list length: " + boxList.length.toString());
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
                        SizedBox(
                          height: 20.0,
                        ),
                        if (this.boxList != null)
                          Container(
                            width: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: DashboardButtonsOverview(
                                    text: "Data box",
                                    onPressed: () {
                                      _searchBoxModal(context);
                                      print(
                                          "Show all boxes in a botttom modal");
                                    },
                                    icon: Icons.insights,
                                  ),
                                ),
                              ],
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
      ),
      floatingActionButton: FloatingActionButtonBOne(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBarBOne(
        active: 1,
      ),
    );
  }

  void _searchBoxModal(context) {
    print("Search box modal");
    // print(
    //     "Search box modal boxlist length = " + this.boxList.length.toString());
    Future<void> future = showModalBottomSheet<void>(
      // isScrollControlled: true, // Full screen height
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30),
        ),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      backgroundColor: Colors.white,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
          return SingleChildScrollView(
              child: Container(
            padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 5.0),
            height: 900,
            color: Theme.of(context).scaffoldBackgroundColor,
            child: Padding(
              padding: EdgeInsets.fromLTRB(25.0, 25.0, 25.0, 5.0),
              child: Column(
                // mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Zoek box',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(10)),
                  Container(
                      height: 80.0,
                      child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: TextFieldBOne(
                            context: context,
                            labelText: "Zoek een box",
                            textInputAction: TextInputAction.done,
                            controller: searchBoxController,
                            icon: Icon(Icons.search),
                          ))),
                  // Padding(
                  //   padding: EdgeInsets.only(
                  //       bottom: MediaQuery.of(context).viewInsets.bottom),
                  //   child: Container(
                  //       height: 80.0,
                  //       child: Padding(
                  //           padding: EdgeInsets.all(8.0),
                  //           child: TextFieldBOne(
                  //             context: context,
                  //             labelText: "Zoek een box",
                  //             textInputAction: TextInputAction.done,
                  //             controller: searchBoxController,
                  //             icon: Icon(Icons.search),
                  //           ))),
                  // ),

                  Text("Gevonden boxen (" +
                      this.boxList.length.toString() +
                      "/" +
                      this.originalBoxList.length.toString() +
                      "):"),
                  Container(
                    child: this.boxList.length != 0
                        ? _boxListItems()
                        : Column(
                            children: <Widget>[
                              SizedBox(
                                height: 30.0,
                              ),
                              Text(
                                'Geen resultaten gevonden!\nProbeer een andere zoekterm.',
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                  ),
                  Padding(padding: EdgeInsets.all(20)),
                ],
              ),
            ),
          ));
        });
      },
    );
    future.then((void value) => _closeModalBox(value));
  }

  void _closeModalBox(void value) {
    print('BoxModal closed');
    setState(() {
      this.boxList = originalBoxList
          .where((box) => box.name
              .toLowerCase()
              .contains(searchBoxController.text.toLowerCase()))
          .toList();
      this.boxList.sort((a, b) {
        return a.name.toLowerCase().compareTo(b.name.toLowerCase());
      });
    });
  }

  ListView _boxListItems() {
    return new ListView.builder(
      primary: false,
      shrinkWrap: true,
      physics: const AlwaysScrollableScrollPhysics(), // new
      scrollDirection: Axis.vertical,
      // shrinkWrap: true,
      itemCount: this.boxList.length,
      itemBuilder: (BuildContext context, int position) {
        return FractionalTranslation(
            translation: Offset(0.0, 0.0),
            child: Stack(children: <Widget>[
              BoxListItem(
                box: this.boxList[position],
                onPressed: () {
                  print("Selected box with id: " +
                      this.boxList[position].id.toString());
                  // Navigate to the data display for an admin
                  _boxDataPage(context, this.boxList[position]);
                },
              ),
              Positioned(
                // Marble to show active status
                top: 10.0,
                right: 10.0,
                child: Icon(Icons.brightness_1,
                    size: 15.0,
                    color: this.boxList[position].active
                        ? Colors.green
                        : Colors.red),
              )
            ]));
      },
    );
  }

  Future<void> _boxDataPage(context, Box box) async {
    bool result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => BoxDataPage(box)),
    );
    if (result == true) {
      _getBoxes();
    }
  }
}
