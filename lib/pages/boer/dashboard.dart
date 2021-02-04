import 'dart:async';
import 'package:b_one_project_4_0/apis/predict_api.dart';
import 'package:b_one_project_4_0/controller/measurementController.dart';
import 'package:b_one_project_4_0/controller/predictController.dart';
import 'package:b_one_project_4_0/controller/terrascopeController.dart';
import 'package:b_one_project_4_0/models/filterMeasurement.dart';
import 'package:b_one_project_4_0/models/measurementGraphics.dart';
import 'package:b_one_project_4_0/models/predict.dart';
import 'package:b_one_project_4_0/models/terrascope.dart';
import 'package:b_one_project_4_0/widgets/BoxUserListItem.dart';
import 'package:b_one_project_4_0/widgets/SafeAreaBOne/safeAreaBOne.dart';
import 'package:b_one_project_4_0/widgets/buttons/BottomAppBarBOne.dart';
import 'package:b_one_project_4_0/widgets/WeatherInfo.dart';
import 'package:b_one_project_4_0/widgets/buttons/TopBarButtons.dart';
import 'package:b_one_project_4_0/controller/userController.dart';
import 'package:b_one_project_4_0/models/box.dart';
import 'package:b_one_project_4_0/widgets/charts/SelectionCallbackPredict.dart';
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
  MeasurementGraphics measurementGraphicsBodemVochtigheid;
  MeasurementGraphics measurementGraphicsTemp;

  //Terrascope IMage
  Terrascope terrascope = new Terrascope();

  //filter box
  FilterMeasurement filterMeasurement = new FilterMeasurement();

  //predictions
  List<Predict> predict = List<Predict>();

  int count = 0;
  User user;

  @override
  void initState() {
    super.initState();
    //TODO is het nodig om al de boxen te laden?
    _getBoxen();
    liveUpdateTimer =
        Timer.periodic(Duration(seconds: 100), (Timer t) => _loadAllGraphics());
    _loadAllGraphics();
    //prediction
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
          terrascope = terr;
        });
      }
    });
  }

  void _setFilterBoxen(Box box) {
    setState(() {
      filterMeasurement.boxID = box.id;
    });

    _loadAllGraphics();
    _loadTerrascopeImage();
    _getPrediciton();
  }

  void _loadAllGraphics() {
    _getMeasurementGraphicLicht();
    _getMeasurementGraphicBodemVochtigheid();
    _getMeasurementGraphicTemp();
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

  void _getMeasurementGraphicBodemVochtigheid() {
    MeasurementController.loadMeasurementsGraphics(
            "Bodemvochtigheid", filterMeasurement)
        .then((measurementGraphicsBodemVochtigheid) {
      //get geleidbaarheid measurements
      setState(() {
        this.measurementGraphicsBodemVochtigheid =
            measurementGraphicsBodemVochtigheid;
      });
    });
  }

  void _getMeasurementGraphicTemp() {
    MeasurementController.loadMeasurementsGraphics(
            "Temperatuur", filterMeasurement)
        .then((measurementGraphicsTemp) {
      setState(() {
        this.measurementGraphicsTemp = measurementGraphicsTemp;
      });
    });
  }

  void _getBoxen() {
    UserController.loadUserWithBoxes().then((result) {
      setState(() {
        if (result.boxes != null) {
          boxList = result.boxes;
          count = result.boxes.length;
        }
      });
    });
  }

  void _getPrediciton() {
    PredictController.fetchPredictByBoxID(this.filterMeasurement)
        .then((predict) {
      setState(() {
        this.predict = predict;
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
                        _weatherView(),
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
                              this.measurementGraphicsBodemVochtigheid,
                          title: "BodemVochtigheid",
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        StackAreacLineChartBone(
                          measurementGraphics: this.measurementGraphicsTemp,
                          title: "Temp",
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        _predictionsView(),
                        SizedBox(
                          height: 40,
                        ),
                        _satellietbeeldView(),
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

  _weatherView() {
    if (this.measurementGraphicsLicht?.boxes?.length != 1) {
      return Container();
    }
    return WeatherInfo(this.measurementGraphicsLicht?.boxes[0].id);
  }

  _predictionsView() {
    if (this.measurementGraphicsLicht?.boxes?.length != 1 ||
        this.predict == null) {
      return Container();
    }
    return SelectionCallbackPredict(
      predictList: this.predict,
      title: "Predict",
    );
  }

  _satellietbeeldView() {
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

    return Column(
      children: [
        Text(this.terrascope.date.toString()),
        Image.network(
          this.terrascope.url,
          alignment: Alignment.center,
        ),
      ],
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
            _getPrediciton();
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
              BoxUserListItem(
                box: boxList[position],
                onPressed: () {
                  _setFilterBoxen(boxList[position]);
                  Navigator.pop(context);
                  // print("Show only the data from one box");
                },
                delete: false,
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
        isScrollControlled: true, // Full screen height
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
                child: Container(
                    // height: 600,
                    color: Colors.white,
                    child: Padding(
                        padding: EdgeInsets.only(top: 25),
                        child:
                            Column(mainAxisSize: MainAxisSize.min, children: [
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
                        ]))));
          });
        });
  }
}
