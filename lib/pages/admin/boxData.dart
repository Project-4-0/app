import 'dart:async';
import 'package:b_one_project_4_0/controller/measurementController.dart';
import 'package:b_one_project_4_0/controller/terrascopeController.dart';
import 'package:b_one_project_4_0/models/filterMeasurement.dart';
import 'package:b_one_project_4_0/models/measurementGraphics.dart';
import 'package:b_one_project_4_0/models/terrascope.dart';
import 'package:b_one_project_4_0/widgets/BoxListItem.dart';
import 'package:b_one_project_4_0/widgets/SafeAreaBOne/safeAreaBOne.dart';
import 'package:b_one_project_4_0/widgets/buttons/BottomAppBarBOne.dart';
import 'package:b_one_project_4_0/widgets/buttons/TopBarButtons.dart';
import 'package:b_one_project_4_0/controller/userController.dart';
import 'package:b_one_project_4_0/controller/boxController.dart';
import 'package:b_one_project_4_0/models/box.dart';
import 'package:b_one_project_4_0/widgets/charts/StackAreacLineChartBone.dart';
import 'package:b_one_project_4_0/widgets/modalButton/ShowModalBottomFilter.dart';
import 'package:b_one_project_4_0/models/user.dart';
import 'package:flutter/material.dart';

class BoxDataPage extends StatefulWidget {
  final Box
      box; // UserDetailPage has an id-parameter which contains the id of the user to show
  BoxDataPage(this.box);

  @override
  _BoxDataPageState createState() => _BoxDataPageState(box);
}

class _BoxDataPageState extends State<BoxDataPage> {
  Box box; // UserDetailPageState has the same id-parameter
  _BoxDataPageState(this.box);

  //liveUpdate Timer
  Timer liveUpdateTimer;

  List<Box> boxList = List<Box>();
  MeasurementGraphics measurementGraphicsLicht;
  MeasurementGraphics measurementGraphicsGeleidbaarheid;

  //Terrascope IMage
  Terrascope terrascope = new Terrascope();

  //filter box
  FilterMeasurement filterMeasurement = new FilterMeasurement();

  int count = 0;
  User user;

  @override
  void initState() {
    super.initState();
    _getBoxes();
    // liveUpdateTimer =
    //     Timer.periodic(Duration(seconds: 100), (Timer t) => _loadAllGraphics());
    // _loadAllGraphics();
    _setFilterBoxen(this.box);
  }

  @override
  void dispose() {
    liveUpdateTimer?.cancel();
    super.dispose();
  }

  void _loadTerrascopeImage() {
    terrascope.url = null;
    terrascope.loading = true;
    TerrascopeController.loadImage(filterMeasurement.boxID).then((terr) {
      if (terr == null) {
        setState(() {
          terrascope.loading = false;
        });
      } else {
        setState(() {
          terrascope.url = terr.url;
        });
      }
    });
  }

  void _setFilterBoxen(Box box) {
    setState(() {
      filterMeasurement.boxID = box.id;
      // filterMeasurement.boxID = 1;
    });

    _loadAllGraphics();
    _loadTerrascopeImage();
  }

  void _loadAllGraphics() {
    _getMeasurementGraphicLicht();
    _getMeasurementGraphicGeleidbaarheid();
  }

  void _getMeasurementGraphicLicht() {
    ////
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

  void _getBoxes() {
    BoxController.loadBoxes().then((result) {
      setState(() {
        if (result != null) {
          boxList = result;
          count = result.length;
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
                          this.box != null ? this.box.name : 'Dashboard',
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
                          onPressedRight: this.boxList != null
                              ? () {
                                  _boxModal(context, this.boxList, this.count);
                                }
                              : null,
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
                        _satellietbeeld(),
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

  _satellietbeeld() {
    if (this.measurementGraphicsLicht?.boxes?.length != 1) {
      return Container();
    }
    return Column(
      children: [
        Padding(padding: EdgeInsets.all(15.0)),
        Text(
          "Satellietbeeld:",
          style: TextStyle(fontSize: 25, color: Colors.black),
        ),
        SizedBox(
          height: 20,
        ),
        SizedBox(
          width: double.infinity,
          // child: TimeSeriesChart(title: "Luchtvochtigheid", animate: true),
          child: _loadImage(),
        ),
        Padding(padding: EdgeInsets.all(15.0)),
      ],
    );
  }

  _loadImage() {
    if (this.terrascope.loading == false) {
      return Center(child: Text("Geen satellietbeeld gevonden"));
    }
    if (this.terrascope.url == null && this.terrascope.loading == true) {
      return Column(children: [
        Text("Afbeelding laden"),
        SizedBox(
          height: 20.0,
        ),
        CircularProgressIndicator(
          valueColor:
              new AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
        )
      ]);
    }

    return Image.network(
      this.terrascope.url,
      alignment: Alignment.center,
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

  ListView _boxItems(boxList, count) {
    return new ListView.builder(
      primary: false,
      shrinkWrap: true,
      physics: AlwaysScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      itemCount: count,
      itemBuilder: (BuildContext context, int position) {
        return FractionalTranslation(
            translation: Offset(0.0, 0.0),
            child: Stack(children: <Widget>[
              BoxListItem(
                box: boxList[position],
                onPressed: () {
                  _setFilterBoxen(boxList[position]);
                  Navigator.pop(context);
                  // print("Show only the data from one box");
                },
              ),
              Positioned(
                // Marble to show active status
                top: 10.0,
                right: 10.0,
                child: Icon(Icons.brightness_1,
                    size: 15.0,
                    color:
                        boxList[position].active ? Colors.green : Colors.red),
              )
            ]));
      },
    );
  }

  void _boxModal(context, boxList, count) {
    showModalBottomSheet(
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
          return StatefulBuilder(builder: (BuildContext context,
              StateSetter setState /*You can rename this!*/) {
            return SingleChildScrollView(
                physics: ScrollPhysics(),
                child: Container(
                    // height: 600,
                    color: Colors.white,
                    margin: const EdgeInsets.only(left: 20.0, right: 20.0),
                    // child: Padding(
                    //     padding: EdgeInsets.all(15),
                    child: Column(
                        // mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Boxen",
                            style: Theme.of(context).textTheme.headline4,
                          ),
                          Container(
                            child: boxList == null
                                ? Center(
                                    child: Text(
                                        "Geen boxen gevonden voor uw account!"))
                                : _boxItems(boxList, count),
                          )
                        ])));
          });
        });
  }
}
