import 'package:b_one_project_4_0/widgets/buttons/OutlineFlatButtonBOne.dart';
import 'package:flutter/material.dart';
import 'package:b_one_project_4_0/apis/box_api.dart';
import 'package:b_one_project_4_0/models/box.dart';
import 'package:b_one_project_4_0/widgets/buttons/BottomAppBarBOne.dart';
import 'package:b_one_project_4_0/widgets/TopSearchBar.dart';
import 'package:b_one_project_4_0/widgets/BoxListItem.dart';
import 'package:qr_flutter/qr_flutter.dart';
// import 'package:share/share.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'dart:typed_data';
import 'dart:ui';
import 'dart:io';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';

class BoxenOverviewPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _BoxenOverviewPage();
}

class _BoxenOverviewPage extends State {
  List<Box> boxList = List<Box>();
  // List boxList = List();
  int count = 0;

GlobalKey globalKey = new GlobalKey();

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
        return FractionalTranslation(
            translation: Offset(0.0, 0.0),
            child: Stack(children: <Widget>[
              BoxListItem(
                boxText: "!!!!!! needs to be replaced",
                box: this.boxList[position],
                onPressed: () {
                  print("Show box detail model");
                  _boxDetail(context, this.boxList[position]);
                },
                locationText: "Geel !!!",
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
  

void _boxDetail(context, Box box) {
  // GlobalKey globalKey = new GlobalKey();

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
        return SingleChildScrollView(
            child: Container(
          // height: 600,
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
                          backgroundColor: Theme.of(context).primaryColor,
                          child: Text("Box naam",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                        ),
                        Positioned(
                          // Marble to show active status
                          top: 0.0,
                          right: 0.0,
                          child: Icon(Icons.brightness_1,
                              size: 30.0,
                              color: box.active ? Colors.green : Colors.red),
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
                      "Locatie:\n" + "Harmoniestraat 44 !!!\n" + "2230 Ramsel",
                      style: TextStyle(fontSize: 18),
                    ),
                    Padding(padding: EdgeInsets.all(5)),
                    Text(
                      "In gebruik door:\n" + "Arno Vangoetsenhoven !!!",
                      style: TextStyle(fontSize: 18),
                    ),
                    if (box.comment != null)
                      Padding(padding: EdgeInsets.all(5)),
                    if (box.comment != null)
                      Text(
                        "Opmerking:\n" + box.comment,
                        style: TextStyle(fontSize: 18),
                      ),
                    Padding(padding: EdgeInsets.all(5)),
                    OutlineFlatButtonBOne(
                      text: "Wijzigen",
                      onPressed: () {
                        print("Go to edit page of box");
                      },
                    ),
                    Padding(padding: EdgeInsets.all(5)),
                    Column(
                      children: <Widget>[
                        RepaintBoundary(
                key: globalKey, 
                child:
                        QrImage(
                            data: box.macAddress,
                            version: QrVersions.auto,
                            size: 150,
                            gapless: false,
                        )),
                        IconButton(
                          icon: Icon(Icons.share, color: Theme.of(context).primaryColor),
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
  );


 
}

   Future<void> _captureAndSharePng(String boxName) async {
    try {
      print("Make image");
      RenderRepaintBoundary boundary = globalKey.currentContext.findRenderObject();
      var image = await boundary.toImage();
      ByteData byteData = await image.toByteData(format: ImageByteFormat.png);
      Uint8List pngBytes = byteData.buffer.asUint8List();

      final tempDir = await getTemporaryDirectory();
      final file = await new File('${tempDir.path}/image.png').create();
      await file.writeAsBytes(pngBytes);
      
await Share.file(boxName, boxName + '.png', byteData.buffer.asUint8List(), 'image/png');

    } catch(e) {
      print(e.toString());
            print("Make image");
    }
  }

}




