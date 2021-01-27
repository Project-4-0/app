import 'package:b_one_project_4_0/widgets/BoxListItem.dart';
import 'package:b_one_project_4_0/widgets/SafeAreaBOne/safeAreaBOne.dart';
import 'package:b_one_project_4_0/widgets/TimeSeriesChart.dart';
import 'package:b_one_project_4_0/widgets/buttons/BottomAppBarBOne.dart';
import 'package:b_one_project_4_0/widgets/buttons/FlatButtonBOne.dart';
import 'package:b_one_project_4_0/widgets/buttons/OutlineFlatButtonBone.dart';
import 'package:b_one_project_4_0/widgets/buttons/TopBarButtons.dart';
import 'package:b_one_project_4_0/apis/box_api.dart';
import 'package:b_one_project_4_0/models/box.dart';
import 'package:flutter/material.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  List<Box> boxList = List<Box>();
  int count = 0;

  @override
  void initState() {
    super.initState();
    _getBoxen();
  }

  void _getBoxen() {
    BoxApi.fetchBoxen().then((result) {
      setState(() {
        boxList = result;
        count = result.length;
        print("Count: " + count.toString());
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
                        // Light sensor
                        SizedBox(
                          width: double.infinity,
                          height: 250.0,
                          child: TimeSeriesChart(
                            title: "Lichthoeveelheid",
                            animate: true,
                            unit: "%",
                            lineColor: Colors.green,
                            meassureAxisValues: [0, 25, 50, 75, 100],
                          ),
                        ),
                        // Temp sensor
                        // SizedBox(
                        //   width: double.infinity,
                        //   height: 250.0,
                        //   // child: TimeSeriesChart(title: "Luchtvochtigheid", animate: true),
                        //   child: TimeSeriesChart.withSampleData(
                        //       title: "Temperatuur",
                        //       animate: true,
                        //       unit: "°C",
                        //       lineColor: Colors.red,
                        //       meassureAxisValues: [
                        //         -20,
                        //         -10,
                        //         0,
                        //         10,
                        //         20,
                        //         30,
                        //         40
                        //       ]),
                        // ),
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
                Padding(padding: EdgeInsets.all(20)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    OutlineFlatButtonBOne(
                      text: "Begin datum",
                      onPressed: () {
                        showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2222),
                        );
                      },
                    ),
                    Padding(padding: EdgeInsets.all(5)),
                    OutlineFlatButtonBOne(
                      text: "Eind datum",
                      onPressed: () {
                        showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2222),
                        );
                      },
                    ),
                  ],
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 20),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          FlatButtonBOne(
                            text: "Filters Toevoegen",
                            onPressed: () {},
                          ),
                        ]),
                  ),
                )
              ],
            ),
          ),
        );
      });
    },
  );
}
