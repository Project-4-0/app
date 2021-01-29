
import 'dart:async';

import 'package:b_one_project_4_0/controller/measurementController.dart';
import 'package:b_one_project_4_0/models/filterMeasurement.dart';
import 'package:b_one_project_4_0/models/measurementGraphics.dart';
import 'package:b_one_project_4_0/widgets/BoxListItem.dart';

import 'package:b_one_project_4_0/widgets/BoxUserListItem.dart';

import 'package:b_one_project_4_0/widgets/SafeAreaBOne/safeAreaBOne.dart';
import 'package:b_one_project_4_0/widgets/buttons/BottomAppBarBOne.dart';
import 'package:b_one_project_4_0/widgets/buttons/TopBarButtons.dart';
import 'package:b_one_project_4_0/controller/boxController.dart';
import 'package:b_one_project_4_0/controller/userController.dart';
import 'package:b_one_project_4_0/models/box.dart';

import 'package:b_one_project_4_0/widgets/charts/StackAreacLineChartBone.dart';
import 'package:b_one_project_4_0/widgets/modalButton/ShowModalBottomFilter.dart';

import 'package:b_one_project_4_0/models/user.dart';

import 'package:flutter/material.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {

  //liveUpdate Timer
  Timer liveUpdateTimer;

  List<Box> boxList = List<Box>();
  MeasurementGraphics measurementGraphicsLicht;
  MeasurementGraphics measurementGraphicsGeleidbaarheid;

  //filter box
  FilterMeasurement filterMeasurement = new FilterMeasurement();

  int count = 0;
  User user;

  @override
  void initState() {
    super.initState();
    //TODO is het nodig om al de boxen te laden?
    // _getBoxen();
    liveUpdateTimer =
        Timer.periodic(Duration(seconds: 50), (Timer t) => _loadAllGraphics());
    _loadAllGraphics();
  }

  @override
  void dispose() {
    liveUpdateTimer?.cancel();
    super.dispose();
  }

  void _loadAllGraphics() {
    _getMeasurementGraphicLicht();
    _getMeasurementGraphicGeleidbaarheid();
  }

  void _getMeasurementGraphicLicht() {
    MeasurementController.loadMeasurementsGraphics("Licht", filterMeasurement)
        .then((measurementGraphicsLicht) {
      //get licht measurements
      setState(() {
        this.measurementGraphicsLicht = measurementGraphicsLicht;
      });
    });
  }

  void _getMeasurementGraphicGeleidbaarheid() {
    MeasurementController.loadMeasurementsGraphics(
            "Geleidbaarheid", filterMeasurement)
        .then((measurementGraphicsGeleidbaarheid) {
      //get geleidbaarheid measurements
      setState(() {
        this.measurementGraphicsGeleidbaarheid =
            measurementGraphicsGeleidbaarheid;
      });
    });
  }

  void _getBoxen() {
    BoxApi.fetchBoxen().then((result) {
      setState(() {
        if (result.boxes != null) {
          boxList = result.boxes;
          count = result.boxes.length;
          print("Count: " + count.toString());
        }
      });
    });
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
                        Padding(padding: EdgeInsets.all(10.0)),
                        TopBarButtons(
                          onPressedLeft: () {
                            _filterModal(context);
                          },
                          onPressedRight: () {
                            _boxModal(context, this.boxList, this.count);
                          },
                          textLeft: "Filters",
                          textRight: "Box",
                          iconLeft: Icons.filter_list,
                          iconRight: Icons.business_center,
                          color: Colors.grey.shade900,
                        ),
                        Padding(padding: EdgeInsets.all(15.0)),
                        StackAreacLineChartBone(
                          measurementGraphics: this.measurementGraphicsLicht,
                          title: "Licht",
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        StackAreacLineChartBone(
                          measurementGraphics:
                              this.measurementGraphicsGeleidbaarheid,
                          title: "Geleidbaarheid",
                        ),
                        Padding(padding: EdgeInsets.all(15.0)),
                        Text("Satellietbeelden:",
                            style: TextStyle(color: Colors.grey[800])),
                        SizedBox(
                            width: double.infinity,
                            height: 250.0,
                            // child: TimeSeriesChart(title: "Luchtvochtigheid", animate: true),
                            child: Image(
                                image: AssetImage('assets/satelite.JPG'))),
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


  void _filterModal(context) {
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
        return ShowModalBottomFilter(
          endDate: this.filterMeasurement.endDate,
          startDate: this.filterMeasurement.startDate,
          startDateCallBack: (date) {
            setState(() {
              this.filterMeasurement.startDate = date;
            });
          },
          endDateCallBack: (date) {
            setState(() {
              this.filterMeasurement.endDate = date;
            });
          },
          onPressedFilter: () {
            _loadAllGraphics();
            Navigator.pop(context);
          },
        );
      },
    );
  }
}

ListView _boxItems(boxList, count) {
  return new ListView.builder(
    primary: false,
    shrinkWrap: true,
    physics: const AlwaysScrollableScrollPhysics(),
    scrollDirection: Axis.vertical,
    itemCount: count,
    itemBuilder: (BuildContext context, int position) {
      return FractionalTranslation(
          translation: Offset(0.0, 0.0),
          child: Stack(children: <Widget>[
            BoxListItem(
              boxText: "!!!!!! needs to be replaced",
              box: boxList[position],
              onPressed: () {
                print("Show only the data from one box");
              },
              locationText: "Geel !!!",
            ),
            Positioned(
              // Marble to show active status
              top: 10.0,
              right: 10.0,
              child: Icon(Icons.brightness_1,
                  size: 15.0,
                  color: boxList[position].active ? Colors.green : Colors.red),
            )
          ]));
    },
  );
}

void _boxModal(context, boxList, count) {
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
            padding: EdgeInsets.only(top: 25),
            child: Column(
              children: [
                Text(
                  "Boxen",
                  style: Theme.of(context).textTheme.headline4,
                ),
                _boxItems(boxList, count),
              ],
            ),
          ),
        );
      });
    },
  );
}
