import 'package:b_one_project_4_0/models/monitoring.dart';
import 'package:b_one_project_4_0/widgets/buttons/OutlineFlatButtonBOne.dart';
import 'package:flutter/material.dart';
import 'package:b_one_project_4_0/controller/boxController.dart';
import 'package:b_one_project_4_0/controller/locationController.dart';
import 'package:b_one_project_4_0/models/box.dart';
import 'package:b_one_project_4_0/models/user.dart';
import 'package:b_one_project_4_0/widgets/buttons/BottomAppBarBOne.dart';
import 'package:b_one_project_4_0/pages/admin/boxDetail.dart';
import 'package:b_one_project_4_0/widgets/TopSearchBar.dart';
import 'package:b_one_project_4_0/widgets/BoxListItem.dart';
import 'package:b_one_project_4_0/widgets/UserListItem.dart';
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
import 'package:b_one_project_4_0/widgets/location_map.dart';

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

  double boxLat;
  double boxLng;

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
    // Get the location of the box
    LocationController.getLocationOfBox(id).then((result) {
      if (result != null) {
        print("Lat: " +
            result.latitude.toString() +
            " Lng: " +
            result.longitude.toString());

        setState(() {
          this.boxLat = result.latitude;
          this.boxLng = result.longitude;
        });
      }
    });

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
                top: 5,
                right: 10.0,
                child: Icon(Icons.brightness_1,
                    size: 20.0,
                    color: this.boxList[position].active
                        ? Colors.green
                        : Colors.red),
              ),
              Positioned(
                // Marble to show active status
                top: 70.0,
                right: 20.0,
                child: this.boxList[position].monitoring.length != 0
                    ? Text(
                        DateFormat('dd-MM-yyyy').format(this
                            .boxList[position]
                            .monitoring[0]
                            .timeStamp), //// !!!!!!!!!!!!!!!!!!!!!
                        style: TextStyle(
                          color: Colors.grey.shade400,
                        ),
                      )
                    : Text(""),
              ),
            ]));
      },
    );
  }

  // Detail modal of a box with all information
  void _boxDetail(context, Box box) {
    // GlobalKey globalKey = new GlobalKey();
    Future<void> future = box != null
        ? showModalBottomSheet<void>(
            isScrollControlled: true,
            // enableDrag: true,
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
                            Padding(padding: EdgeInsets.all(5)),
                            Text(
                              "In gebruik door:",
                              style: TextStyle(fontSize: 20),
                            ),
                            Container(
                              child: _userList(context, box.users),
                            ),
                            if (box.comment != null &&
                                box.comment != "" &&
                                box.comment != " " &&
                                box.comment.isNotEmpty)
                              Padding(padding: EdgeInsets.all(5)),
                            if (box.comment != null &&
                                box.comment != "" &&
                                box.comment != " " &&
                                box.comment.isNotEmpty)
                              Text(
                                "Opmerking:\n" + box.comment,
                                style: TextStyle(fontSize: 20),
                              ),
                            Padding(padding: EdgeInsets.all(5)),
                            Text(
                              "Sensors:",
                              style: TextStyle(fontSize: 20),
                            ),
                            box.sensors != null
                                ? Container(
                                    child: _sensorList(context, box.sensors),
                                  )
                                : Text("Geen gegevens beschikbaar!",
                                    textAlign: TextAlign.center),
                            Padding(padding: EdgeInsets.all(5)),
                            Text(
                              "Monitoring:",
                              style: TextStyle(fontSize: 20),
                            ),
                            Padding(padding: EdgeInsets.all(5)),
                            box.monitoring.length != 0
                                ? _monitoring(box.monitoring[0])
                                : Text("Geen gegevens beschikbaar!",
                                    textAlign: TextAlign.center),
                            Padding(padding: EdgeInsets.all(5)),
                            Text(
                              "Locatie:",
                              style: TextStyle(fontSize: 20),
                            ),
                            Padding(padding: EdgeInsets.all(5)),

                            // this.boxLat != null && boxLng != null
                            //     ? Container(
                            //         height: 200.0,
                            //         child:
                            //             LocationMap(this.boxLat, this.boxLng))
                            //     : Container(
                            //         height: 200.0,
                            //         child: Center(
                            //             child: CircularProgressIndicator())),
                            this.boxLat != null && boxLng != null
                                ? Container(
                                    height: 200.0,
                                    child:
                                        LocationMap(this.boxLat, this.boxLng))
                                : Container(
                                    height: 200.0,
                                    child: Center(
                                        child: CircularProgressIndicator())),
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
        : showModalBottomSheet<void>(
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
    future.then((void value) => _closeModalBox(value));
  }

  void _closeModalBox(void value) {
    print('BoxModal closed');
    setState(() {
      this.boxLat = null;
      this.boxLng = null;
    });
  }

  _monitoring(Monitoring monitoring) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.sd_card, size: 40, color: Colors.grey.shade500),
            Text(monitoring.sdCapacity == "" ? "Geen" : monitoring.sdCapacity)
          ],
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.battery_alert, size: 40, color: Colors.grey.shade500),
            Text(monitoring.batteryPercentage == ""
                ? "Geen"
                : monitoring.batteryPercentage)
          ],
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.thermostat_outlined,
                size: 40, color: Colors.grey.shade500),
            Text(monitoring.temperature == "" ? "Geen" : monitoring.temperature)
          ],
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.history, size: 40, color: Colors.grey.shade500),
            Text(
              DateFormat('dd/MM/yyyy \n kk:mm:ss').format(monitoring.timeStamp),
            ),
          ],
        ),
      ],
    );
  }

  ListView _userList(context, List<User> userList) {
    return new ListView.builder(
      primary: false,
      shrinkWrap: true,
      physics: const AlwaysScrollableScrollPhysics(), // new
      scrollDirection: Axis.vertical,
      // shrinkWrap: true,
      itemCount: userList.length,
      itemBuilder: (BuildContext context, int position) {
        return UserListItem(
          user: userList[position],
          showTrailingIcon: false,
          onPressed: () {
            print("Pressed trailing icon");
            // _userDetail(userList[position].id);
          },
        );
      },
    );
  }

  // ListView _userList(context, List<User> userList) {
  //   return new ListView.builder(
  //     primary: false,
  //     shrinkWrap: true,
  //     // physics: const AlwaysScrollableScrollPhysics(), // new
  //     scrollDirection: Axis.vertical,
  //     itemCount: userList.length,
  //     itemBuilder: (context, int position) {
  //       return Card(
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(10.0),
  //         ),
  //         color: Colors.white,
  //         elevation: 2.0,
  //         child: ListTile(
  //           leading: Column(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: <Widget>[
  //               // Show the first letter of the last name
  //               CircleAvatar(
  //                 backgroundColor: Theme.of(context).primaryColor,
  //                 child: Text(
  //                     userList[position].firstName.substring(0, 1) +
  //                         userList[position].lastName.substring(0, 1),
  //                     style: TextStyle(
  //                         color: Colors.white, fontWeight: FontWeight.bold)),
  //               ),
  //             ],
  //           ),
  //           title: Text(
  //             userList[position].firstName + " " + userList[position].lastName,
  //             style: TextStyle(
  //                 fontWeight: FontWeight.bold,
  //                 color: Theme.of(context).primaryColor),
  //           ),
  //           subtitle: Column(
  //             children: [
  //               Align(
  //                   alignment: Alignment.centerLeft,
  //                   child: Row(
  //                     children: <Widget>[
  //                       Padding(
  //                         padding: EdgeInsets.all(4.0),
  //                       ),
  //                       // Icon(Icons.mail_outline, size: 14, color: Colors.blue),
  //                       GestureDetector(
  //                           onTap: () {
  //                             print("Tapped on email!");
  //                             // _launchMailto(
  //                             //     this.userList[position].email.toString(),
  //                             //     this.userList[position].firstName,
  //                             //     this.userList[position].lastName);
  //                           },
  //                           child: Icon(Icons.mail_outline,
  //                               size: 14,
  //                               color: Theme.of(context).primaryColor)),
  //                       Padding(
  //                         padding: EdgeInsets.all(4.0),
  //                       ),
  //                       SizedBox(
  //                           width: 170.0,
  //                           child: GestureDetector(
  //                             onTap: () {
  //                               print("Tapped on email!");
  //                               // _launchMailto(
  //                               //     this.userList[position].email.toString(),
  //                               //     this.userList[position].firstName,
  //                               //     this.userList[position].lastName);
  //                             },
  //                             child: Text(
  //                               userList[position].email.toString(),
  //                               maxLines: 1,
  //                               overflow: TextOverflow.fade,
  //                               softWrap: false,
  //                             ),
  //                           )),
  //                     ],
  //                   )),
  //               Align(
  //                 alignment: Alignment.centerLeft,
  //                 child: Row(
  //                   children: <Widget>[
  //                     Padding(
  //                       padding: EdgeInsets.all(4.0),
  //                     ),
  //                     GestureDetector(
  //                         onTap: () {
  //                           print("Tapped on location!");
  //                           // _openGoogleMaps(
  //                           //     this.userList[position].address,
  //                           //     this.userList[position].city,
  //                           //     this.userList[position].postalCode);
  //                         },
  //                         child: Icon(
  //                           Icons.place,
  //                           size: 14,
  //                           color: Theme.of(context).primaryColor,
  //                         )),
  //                     Padding(
  //                       padding: EdgeInsets.all(4.0),
  //                     ),
  //                     GestureDetector(
  //                         onTap: () {
  //                           print("Tapped on location!");
  //                           // _openGoogleMaps(
  //                           //     this.userList[position].address,
  //                           //     this.userList[position].city,
  //                           //     this.userList[position].postalCode);
  //                         },
  //                         child: Text(userList[position].address +
  //                             ",\n" +
  //                             userList[position].city +
  //                             " " +
  //                             userList[position].postalCode)),
  //                   ],
  //                 ),
  //               ),
  //               Align(
  //                 alignment: Alignment.bottomRight,
  //                 child: Text(
  //                   "Start: " +
  //                       DateFormat('dd/MM/yyyy – kk:mm:ss')
  //                           .format(userList[position].boxUser.startDate),
  //                 ),
  //               ),
  //             ],
  //           ),
  //           // trailing: IconButton(
  //           //   icon: Icon(Icons.navigate_next),
  //           //   color: Theme.of(context).accentColor,
  //           //   tooltip: 'Open actions menu',
  //           //   onPressed: () {
  //           //     print("Pressed trailing icon");
  //           //     // _userDetail(this.userList[position].id);
  //           //   },
  //           // ),
  //           // isThreeLine: true,
  //           // // subtitle: Text(this.userList[position].email),
  //           // onTap: () {
  //           //   // debugPrint("Tapped on " + this.userList[position].id.toString());
  //           //   print("Navigate to detail");
  //           //   // _userDetail(this.userList[position].id);
  //           // },
  //         ),
  //       );

  //       // return Padding(
  //       //     padding: EdgeInsets.only(top: 5.0),
  //       //     child: GestureDetector(
  //       //         onTap: () {
  //       //           print("Tapped on user");
  //       //         },
  //       //         child: Column(
  //       //           children: [
  //       //             Row(
  //       //               children: <Widget>[
  //       //                 Padding(
  //       //                   padding: EdgeInsets.fromLTRB(15.0, 0, 5.0, 0),
  //       //                   child: Icon(
  //       //                     Icons.perm_identity,
  //       //                     color: Theme.of(context).primaryColor,
  //       //                     size: 14,
  //       //                   ),
  //       //                 ),
  //       //                 Container(
  //       //                     child: Flexible(
  //       //                         child: Text(
  //       //                             userList[position].firstName +
  //       //                                 " " +
  //       //                                 userList[position].lastName +
  //       //                                 ":",
  //       //                             textAlign: TextAlign.left,
  //       //                             ),
  //       //                             ),
  //       //                             ),
  //       //               ],
  //       //             ),
  //       //             Row(
  //       //               children: <Widget>[
  //       //                 Padding(
  //       //                   padding: EdgeInsets.fromLTRB(40.0, 0, 5.0, 0),
  //       //                   child: Icon(
  //       //                     Icons.place,
  //       //                     color: Theme.of(context).primaryColor,
  //       //                     size: 14,
  //       //                   ),
  //       //                 ),
  //       //                 Container(
  //       //                     child: Flexible(
  //       //                         child: Text(
  //       //                             userList[position].address +
  //       //                                 ",\n " +
  //       //                                 userList[position].postalCode +
  //       //                                 " " +
  //       //                                 userList[position].city,
  //       //                             textAlign: TextAlign.left))),
  //       //               ],
  //       //             ),
  //       //             Row(
  //       //               children: <Widget>[
  //       //                 Padding(
  //       //                   padding: EdgeInsets.fromLTRB(40.0, 0, 5.0, 0),
  //       //                   child: Icon(
  //       //                     Icons.today,
  //       //                     color: Theme.of(context).primaryColor,
  //       //                     size: 14,
  //       //                   ),
  //       //                 ),
  //       //                 Container(
  //       //                     child: Flexible(
  //       //                         child: Text(
  //       //                             DateFormat('dd/MM/yyyy – kk:mm:ss').format(
  //       //                                     userList[position]
  //       //                                         .boxUser
  //       //                                         .startDate) +
  //       //                                 (userList[position].boxUser.endDate !=
  //       //                                         null
  //       //                                     ? (" - \n" +
  //       //                                         DateFormat(
  //       //                                                 'dd/MM/yyyy – kk:mm:ss')
  //       //                                             .format(userList[position]
  //       //                                                 .boxUser
  //       //                                                 .endDate))
  //       //                                     : ""),
  //       //                             textAlign: TextAlign.left))),
  //       //               ],
  //       //             )
  //       //           ],
  //       //         ),
  //       //         ),
  //       //         );
  //     },
  //   );
  // }

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
