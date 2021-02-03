import 'package:b_one_project_4_0/widgets/buttons/OutlineFlatButtonBOne.dart';
import 'package:flutter/material.dart';
import 'package:b_one_project_4_0/controller/boxController.dart';
import 'package:b_one_project_4_0/models/box.dart';
import 'package:b_one_project_4_0/models/user.dart';
import 'package:b_one_project_4_0/widgets/buttons/BottomAppBarBOne.dart';
import 'package:b_one_project_4_0/pages/admin/boxDetail.dart';
import 'package:b_one_project_4_0/widgets/TopSearchBar.dart';
import 'package:b_one_project_4_0/widgets/BoxListItem.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'dart:typed_data';
import 'dart:ui';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';

class BoxenOverviewPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _BoxenOverviewPage();
}

class _BoxenOverviewPage extends State {
  List<Box> boxList = List<Box>();
  List<Box> originalBoxList = List<Box>();
  Box boxAll;
  // List boxList = List();
  int count = 0;

  GlobalKey globalKey = new GlobalKey();

  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    searchController.addListener(_searchValueChanged);
    _getBoxes();
  }

  void _searchValueChanged() {
    print("Second text field: ${searchController.text}");
    setState(() {
      this.boxList = originalBoxList
          .where((box) => box.name
              .toLowerCase()
              .contains(searchController.text.toLowerCase()))
          .toList();
      this.boxList.sort((a, b) {
        return a.name.toLowerCase().compareTo(b.name.toLowerCase());
      });
    });
    print("Filtered box list length: " + boxList.length.toString());
  }

  void _getBoxes() {
    BoxController.loadBoxes().then((result) {
      setState(() {
        originalBoxList = result;
        originalBoxList.sort((a, b) {
          return a.name.toLowerCase().compareTo(b.name.toLowerCase());
        });
        boxList = originalBoxList; // Page loaded so list isn't filtered
        count = result.length;
        print("Count: " + count.toString());
      });
    });
  }

  void _showBoxDetail(int id) {
    // Get all the box info to show the details
    BoxController.loadBoxAll(id).then((result) {
      setState(() {
        boxAll = result;
      });
      // Open the detail modal
      _boxDetail(context, this.boxAll);
    });
  }

  Future<void> _updateBoxPage(id) async {
    bool result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => BoxDetailPage(id)),
    );
    if (result == true) {
      _getBoxes();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        // TODO: go to box detail with empty values
                        print("Pressed add box");
                        Navigator.pushNamed(context, '/admin/boxen/new');
                      },
                      textRight: "Box",
                      iconRight: Icons.business_center,
                      controller: searchController,
                      color: Colors.grey.shade900,
                    ),
                    Padding(padding: EdgeInsets.all(10.0)),
                    Expanded(
                      child: this.boxList.length != 0
                          ? _boxListItems()
                          : Column(
                              children: <Widget>[
                                Text('Geen resultaten gevonden!'),
                                Expanded(
                                    child: Center(
                                        child: CircularProgressIndicator())),
                              ],
                            ),
                    ),
                  ]),
            ),
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
                  print("Show box detail model");
                  _showBoxDetail(this.boxList[position].id);
                  // _boxDetail(context, this.boxList[position]);
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

  // Detail modal of a box with all information
  void _boxDetail(context, Box box) {
    // GlobalKey globalKey = new GlobalKey();

    box != null
        ? showModalBottomSheet(
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
                  // height: 900,
                  color: Colors.white,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(25.0, 25.0, 25.0, 5.0),
                    child: Column(
                      children: [
                        FractionalTranslation(
                            translation: Offset(0.0, 0.0),
                            child: Align(
                              child: Stack(children: <Widget>[
                                CircleAvatar(
                                    radius: 50.0,
                                    backgroundColor:
                                        Theme.of(context).primaryColor,
                                    child: Padding(
                                      padding: EdgeInsets.all(16.0),
                                      child: Text(box.name,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                          textAlign: TextAlign.center),
                                    )),
                                Positioned(
                                  // Marble to show active status
                                  top: 0.0,
                                  right: 0.0,
                                  child: Icon(Icons.brightness_1,
                                      size: 30.0,
                                      color: box.active
                                          ? Colors.green
                                          : Colors.red),
                                )
                              ]),
                              alignment: FractionalOffset(0.5, 0.0),
                            )),
                        Padding(padding: EdgeInsets.all(20)),
                        // Values of box
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              "Mac adress:\n" + box.macAddress,
                              style: TextStyle(fontSize: 18),
                            ),
                            // Padding(padding: EdgeInsets.all(5)),
                            // Text(
                            //   "Locatie:\n" +
                            //       "Harmoniestraat 44 !!!\n" +
                            //       "2230 Ramsel",
                            //   style: TextStyle(fontSize: 18),
                            // ),
                            Padding(padding: EdgeInsets.all(5)),
                            Text(
                              "In gebruik door:",
                              style: TextStyle(fontSize: 18),
                            ),
                            Container(
                              child: _userList(context, box.users),
                            ),
                            if (box.comment != null)
                              Padding(padding: EdgeInsets.all(5)),
                            if (box.comment != null)
                              Text(
                                "Opmerking:\n" + box.comment,
                                style: TextStyle(fontSize: 18),
                              ),
                            Padding(padding: EdgeInsets.all(5)),
                            Text(
                              "Sensors:",
                              style: TextStyle(fontSize: 18),
                            ),
                            Container(
                              child: _sensorList(context, box.sensors),
                            ),
                            Padding(padding: EdgeInsets.all(5)),
                            OutlineFlatButtonBOne(
                              text: "Wijzigen",
                              onPressed: () {
                                print("Go to edit page of box");
                                _updateBoxPage(box.id);
                              },
                            ),
                            Padding(padding: EdgeInsets.all(5)),
                            Column(
                              children: <Widget>[
                                RepaintBoundary(
                                    key: globalKey,
                                    child: QrImage(
                                      data: box.macAddress,
                                      version: QrVersions.auto,
                                      size: 150,
                                      gapless: false,
                                    )),
                                IconButton(
                                  icon: Icon(Icons.share,
                                      color: Theme.of(context).primaryColor),
                                  tooltip: 'Increase volume by 10',
                                  onPressed: () {
                                    print("Share QR-Code");
                                    _captureAndSharePng(box.name);
                                  },
                                ),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ));
              });
            },
          )
        : showModalBottomSheet(
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
              return StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState) {
                return SingleChildScrollView(
                    child: Container(
                  // height: 900,
                  color: Colors.white,
                  child: Center(child: CircularProgressIndicator()),
                ));
              });
            },
          );
  }

  ListView _userList(context, List<User> userList) {
    return new ListView.builder(
      primary: false,
      shrinkWrap: true,
      // physics: const AlwaysScrollableScrollPhysics(), // new
      scrollDirection: Axis.vertical,
      itemCount: userList.length,
      itemBuilder: (context, int position) {
        return Padding(
            padding: EdgeInsets.only(top: 5.0),
            child: GestureDetector(
                onTap: () {
                  print("Tapped on user");
                },
                child: Column(
                  children: [
                    Row(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.fromLTRB(15.0, 0, 5.0, 0),
                          child: Icon(
                            Icons.perm_identity,
                            color: Theme.of(context).primaryColor,
                            size: 14,
                          ),
                        ),
                        Container(
                            child: Flexible(
                                child: Text(
                                    userList[position].firstName +
                                        " " +
                                        userList[position].lastName +
                                        ":",
                                    textAlign: TextAlign.left))),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.fromLTRB(40.0, 0, 5.0, 0),
                          child: Icon(
                            Icons.place,
                            color: Theme.of(context).primaryColor,
                            size: 14,
                          ),
                        ),
                        Container(
                            child: Flexible(
                                child: Text(
                                    userList[position].address +
                                        ",\n " +
                                        userList[position].postalCode +
                                        " " +
                                        userList[position].city,
                                    textAlign: TextAlign.left))),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.fromLTRB(40.0, 0, 5.0, 0),
                          child: Icon(
                            Icons.today,
                            color: Theme.of(context).primaryColor,
                            size: 14,
                          ),
                        ),
                        Container(
                            child: Flexible(
                                child: Text(
                                    DateFormat('dd/MM/yyyy – kk:mm:ss').format(
                                            userList[position]
                                                .boxUser
                                                .startDate) +
                                        (userList[position].boxUser.endDate !=
                                                null
                                            ? (" - \n" +
                                                DateFormat(
                                                        'dd/MM/yyyy – kk:mm:ss')
                                                    .format(userList[position]
                                                        .boxUser
                                                        .endDate))
                                            : ""),
                                    textAlign: TextAlign.left))),
                      ],
                    )
                  ],
                )));
      },
    );
  }

  ListView _sensorList(context, sensorList) {
    return new ListView.builder(
      primary: false,
      shrinkWrap: true,
      // physics: const AlwaysScrollableScrollPhysics(), // new
      scrollDirection: Axis.vertical,
      itemCount: sensorList.length,
      itemBuilder: (context, int position) {
        return Padding(
            padding: EdgeInsets.only(top: 5.0),
            child: Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(15.0, 0, 5.0, 0),
                  child: Icon(
                    Icons.settings_input_hdmi,
                    color: Theme.of(context).primaryColor,
                    size: 14,
                  ),
                ),
                Container(
                    child: Flexible(
                        child: Text(sensorList[position].name,
                            textAlign: TextAlign.left))),
              ],
            ));
      },
    );
  }

  Future<void> _captureAndSharePng(String boxName) async {
    try {
      print("Make image");
      RenderRepaintBoundary boundary =
          globalKey.currentContext.findRenderObject();
      var image = await boundary.toImage();
      ByteData byteData = await image.toByteData(format: ImageByteFormat.png);
      Uint8List pngBytes = byteData.buffer.asUint8List();

      final tempDir = await getTemporaryDirectory();
      final file = await new File('${tempDir.path}/image.png').create();
      await file.writeAsBytes(pngBytes);

      await Share.file(boxName, boxName + '.png', byteData.buffer.asUint8List(),
          'image/png');
    } catch (e) {
      print(e.toString());
      print("Make image");
    }
  }
}
