import 'package:flutter/material.dart';
import 'package:b_one_project_4_0/apis/box_api.dart';
import 'package:b_one_project_4_0/models/box.dart';
import 'package:b_one_project_4_0/widgets/buttons/BottomAppBarBOne.dart';
import 'package:b_one_project_4_0/widgets/TopSearchBar.dart';
import 'package:b_one_project_4_0/widgets/BoxListItem.dart';
import 'package:badges/badges.dart';

class BoxenOverviewPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _BoxenOverviewPage();
}

class _BoxenOverviewPage extends State {
  List<Box> boxList = List<Box>();
  // List boxList = List();
  int count = 0;

  final GlobalKey<ScaffoldState> _scaffoldKeyUsers =
      new GlobalKey<ScaffoldState>();

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

// TODO: Go to user dertail by id;
  void _userDetail(int id) {
    Navigator.pushNamedAndRemoveUntil(
        context, 'admin/users/1', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKeyUsers,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Container(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Boxen',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    Padding(padding: EdgeInsets.all(10.0)),
                    TopSearchBar(
                      onPressedRight: () {
                        // TODO: go to user detail with empty values
                        print("Pressed add box");
                      },
                      textRight: "Box",
                      iconRight: Icons.business_center,
                      color: Colors.grey.shade900,
                    ),
                    Padding(padding: EdgeInsets.all(10.0)),
                    Expanded(
                      child: this.count != 0
                          ? _boxListItems()
                          : Center(child: CircularProgressIndicator()),
                    ),
                  ]),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButtonBOne(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBarBOne(),
    );
  }

  ListView _boxListItems() {
    return new ListView.builder(
      primary: false,
      shrinkWrap: true,
      physics: const AlwaysScrollableScrollPhysics(), // new
      scrollDirection: Axis.vertical,
      // shrinkWrap: true,
      itemCount: count,
      itemBuilder: (BuildContext context, int position) {
        return BoxListItem(
          onPressed: () {
            print("Show box detail model");
            _boxDetail(context, this.boxList[position]);
          },
          boxText: this.boxList[position].name,
          locationText: "Geel",
        );
      },
    );
  }
}

void _boxDetail(context, Box box) {
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
                FractionalTranslation(
                    translation: Offset(0.0, -0.0),
                    child: Align(
                      child: new Stack(children: <Widget>[
                        CircleAvatar(
                          radius: 50.0,
                          backgroundColor: Theme.of(context).primaryColor,
                          child: Text("Box naam",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                        ),
                        new Positioned(
                          // Marble to show active status
                          top: 0.0,
                          right: 0.0,
                          child: new Icon(Icons.brightness_1,
                              size: 30.0, color: box.active? Colors.green: Colors.red),
                        )
                      ]),
                      alignment: FractionalOffset(0.5, 0.0),
                    )),
                Padding(padding: EdgeInsets.all(20)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text("Mac adress:"),
                    Text(box.macAddress),
                    Padding(padding: EdgeInsets.all(5)),
                    Text("Locatie:"),
                    Text(box.macAddress),
                    Padding(padding: EdgeInsets.all(5)),
                    Text("Opmerking:"),
                    Text(box.comment),
                    // OutlineFlatButtonBOne(
                    //   text: "Eind datum",
                    //   onPressed: () {
                    //     showDatePicker(
                    //       context: context,
                    //       initialDate: DateTime.now(),
                    //       firstDate: DateTime(2000),
                    //       lastDate: DateTime(2222),
                    //     );
                    //   },
                    // ),
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
                          // FlatButtonBOne(
                          //   text: "Filters Toevoegen",
                          //   onPressed: () {},
                          // ),
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
