import 'dart:ffi';
import 'dart:io';

import 'package:b_one_project_4_0/widgets/CardBOne.dart';
import 'package:b_one_project_4_0/widgets/SafeAreaBOne/safeAreaBOne.dart';
import 'package:b_one_project_4_0/widgets/TextFieldBOne.dart';
import 'package:b_one_project_4_0/widgets/buttons/BottomAppBarBOne.dart';
import 'package:b_one_project_4_0/widgets/buttons/DashboardButtonsOverview.dart';
import 'package:b_one_project_4_0/widgets/buttons/FlatButtonBOne.dart';
import 'package:b_one_project_4_0/widgets/BoxListItem.dart';
import 'package:b_one_project_4_0/widgets/UserListItem.dart';
import 'package:b_one_project_4_0/controller/boxController.dart';
import 'package:b_one_project_4_0/controller/userController.dart';
import 'package:b_one_project_4_0/models/box.dart';
import 'package:b_one_project_4_0/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:im_stepper/stepper.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:mailto/mailto.dart';
import 'package:url_launcher/url_launcher.dart';

class MonteurConnectedPage extends StatefulWidget {
  @override
  _MonteurConnectedPageState createState() => _MonteurConnectedPageState();
}

class _MonteurConnectedPageState extends State<MonteurConnectedPage> {
  int activeStep = 0; // Initial step set to 5.
  List<Box> boxList = List<Box>();
  List<Box> originalBoxList = List<Box>();
    List<User> userList = List<User>();
  List<User> originalUserList = List<User>();

bool barcodeFound;

  Box selectedBox; 
  User selectedUser; 

    TextEditingController searchBoxController = TextEditingController();
    TextEditingController searchUserController = TextEditingController();


  // Must be used to control the upper bound of the activeStep variable. Please see next button below the build() method!
  int upperBound = 0;

  //QRCODE
  Barcode result;
  QRViewController controller;
  bool canShowQRScanner = false;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    print("Reassemble");
    if (Platform.isAndroid) {
      controller.pauseCamera();
    } else if (Platform.isIOS) {
      controller.resumeCamera();
    }
  }

  @override
  void initState() {
    super.initState();
    this.barcodeFound = false;
    // _getUsers();
    searchBoxController.addListener(_searchBoxValueChanged);
    searchUserController.addListener(_searchUserValueChanged);
  }

    void _getBoxes() {
      print("Get boxes!");
      // Pause the camera when te mannualy search modal is opened
            controller.pauseCamera();

    BoxController.loadBoxes().then((result) {
      setState(() {
        originalBoxList = result;
        originalBoxList.sort((a, b) {
          return a.name.toLowerCase().compareTo(b.name.toLowerCase());
        });
        boxList = originalBoxList;
      });
      // Open the modal
      _searchBoxModal(context);  
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

      void _getUsers() {
      print("Get users!");
    UserController.loadUsers().then((result) {
      setState(() {
        originalUserList = result;
        originalUserList.sort((a, b) {
          return a.lastName.toLowerCase().compareTo(b.lastName.toLowerCase());
        });
        userList = originalUserList;
      });
      // Open the modal
      _searchUserModal(context);  
    });
  }

      void _searchUserValueChanged() {
    print("User search text field: ${searchUserController.text}");
    setState(() {
      this.userList = originalUserList
          .where((user) =>
              user.firstName
                  .toLowerCase()
                  .contains(searchUserController.text.toLowerCase()) ||
              user.lastName
                  .toLowerCase()
                  .contains(searchUserController.text.toLowerCase()) ||
              user.email
                  .toLowerCase()
                  .contains(searchUserController.text.toLowerCase()) ||
              user.address
                  .toLowerCase()
                  .contains(searchUserController.text.toLowerCase()) ||
              user.city
                  .toLowerCase()
                  .contains(searchUserController.text.toLowerCase()) ||
              user.postalCode
                  .toLowerCase()
                  .contains(searchUserController.text.toLowerCase()))
          .toList();
      // Users sorted alphabetical by last name
      this.userList.sort((a, b) {
        return a.lastName.toLowerCase().compareTo(b.lastName.toLowerCase());
      });
    });
    print("Filtered user list length: " + userList.length.toString());
  }

      void _searchBoxByMacAddress(String macAddress) {
      print("Search box by mac!");
            // controller.pauseCamera();

    BoxController.loadBoxWithMacAddress(macAddress).then((result) {
      setState(() {
        this.selectedBox = result;
      });

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: safeAreaBOne(),
            child: Center(
              child: Column(
                children: [
                  Text(
                    'Koppelen',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(15.0)),
                  IconStepper(
                    stepColor: Theme.of(context).accentColor,
                    lineColor: Theme.of(context).accentColor,
                    activeStepColor: Theme.of(context).primaryColor,
                    activeStepBorderColor: Theme.of(context).accentColor,
                    icons: [
                      Icon(
                        Icons.camera_alt,
                        color: Colors.white,
                      ),
                      Icon(
                        Icons.person,
                        color: Colors.white,
                      ),
                      Icon(
                        Icons.comment,
                        color: Colors.white,
                      ),
                      Icon(
                        Icons.flag,
                        color: Colors.white,
                      ),
                    ],

                    // activeStep property set to activeStep variable defined above.
                    activeStep: activeStep,

                    // bound receives value from upperBound.
                    upperBound: (bound) => upperBound = bound,

                    // This ensures step-tapping updates the activeStep.
                    onStepReached: (index) {
                      setState(() {
                        activeStep = index;
                      });
                    },
                  ),
                  header(),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      previousButton(),
                      nextButton(),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButtonBOne(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBarBOne(active: 1,),
    );
  }

  /// Returns the next button.
  Widget nextButton() {
    return FlatButtonBOne(
      text: "Volgend",
      // onPressed: this.activeStep==0&&selectedBox==null ? null
      // :
      // () {
      //   if (activeStep < upperBound) {
      //     setState(() {
      //       activeStep++;
      //     });
      //   }
      // },
            onPressed: 
      () {
                if (activeStep == 0) {
controller.pauseCamera();
        }
        if (activeStep < upperBound) {
          setState(() {
            activeStep++;
          });
        }
      },
    );
  }

  /// Returns the previous button.
  Widget previousButton() {
    return FlatButtonBOne(
      text: "Terug",
      onPressed: this.activeStep==0 ? null : () {
        if (activeStep > 0) {
          setState(() {
            activeStep--;
          });
        }
      },
    );
  }

  /// Returns the header wrapping the header text.
  Widget header() {
    return headerText();
  }

  // Returns the header text based on the activeStep.
  Widget headerText() {
    switch (activeStep) {
      //TODO handmatig add modal
      case 0:
        return Column(
          children: [
            Container(
              height: 450,
              width: double.infinity,
              child: Column(
                children: [
                  Text(
                    "Box",
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Expanded(flex: 5, child: _buildQrView(context)),
                  Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        if (result != null && this.barcodeFound)
                        // Macaddress
                          Text(
                              'Barcode Type: ${describeEnum(result.format)}   Data: ${result.code}')
                        else
                          Text('Scan de QR code'),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: FlatButtonBOne(
                      minWidth: double.infinity,
                      text: "Handmatig zoeken",
                      onPressed: () {
print("Box handmatig zoeken");
_getBoxes(); // Get all the boxes to search manually and open the search modal
},
                    ),
                  ),
                  if(this.selectedBox!=null)
                  Column(
                    children: [
          Padding(padding: EdgeInsets.only(top: 30)),
          Text("Geselcteerde box:"),
                                BoxListItem(
                boxText: "",
                box: selectedBox,
                onPressed: null,
                locationText: "",
              ),
                         IconButton(
          icon: Icon(Icons.delete, color: Colors.red),
          onPressed: () {
            print("DeleteSelectedBox!");
                setState(() {
this.selectedBox = null;
this.barcodeFound = false;    });
          },
        ),
                    ]
                  )
                ],
              ),
            ),
          ],
        );
        // Gebruiker
      case 1:
        return Padding(
          padding: const EdgeInsets.only(top: 30),
          child: Column(
            children: [
              Text(
                "Gebruiker",
                style: Theme.of(context).textTheme.bodyText2,
              ),
              SizedBox(
                height: 30,
              ),
              DashboardButtonsOverview(
                minWidth: double.infinity,
                text: "Registeren",
                onPressed: () {},
                icon: Icons.group,
              ),
              SizedBox(
                height: 30,
              ),
              DashboardButtonsOverview(
                minWidth: double.infinity,
                text: "Gebruiker zoeken",
                onPressed: () {
                  print("Search user modal");
                  _getUsers();
                  // _searchUserModal(context);
                },
                icon: Icons.group,
              ),
              SizedBox(
                height: 30,
              ),
              if(this.selectedUser!=null)
                Column(
                  children: [
          Padding(padding: EdgeInsets.only(top: 30)),
          Text("Geselcteerde gebruiker:"),
                                BoxListItem(
                boxText: "",
                box: selectedBox,
                onPressed: null,
                locationText: "",
              ),
                         IconButton(
          icon: Icon(Icons.delete, color: Colors.red),
          onPressed: () {
            print("DeleteSelectedBox!");
                setState(() {
this.selectedBox = null;
this.barcodeFound = false;    });
          },
        ),
                    ]
                  )
            ],
          ),
        );
// Overview + opmerking
      case 2:
        return Padding(
          padding: const EdgeInsets.only(top: 30),
          child: Column(
            children: [
              Text(
                "Bevestigen",
                style: Theme.of(context).textTheme.bodyText2,
              ),
              CardBOne(
                child: Text("Box"),
              ),
              CardBOne(
                child: Text("User"),
              ),
              SizedBox(
                height: 30,
              ),
              TextFieldBOne(
                context: context,
                labelText: "Opmerkingen",
                keyboardType: TextInputType.multiline,
                maxLength: 100,
              ),
            ],
          ),
        );
// Confirmation
      case 3:
        return Padding(
          padding: const EdgeInsets.only(top: 30),
          child: Column(
            children: [
              Text(
                "Final",
                style: Theme.of(context).textTheme.bodyText2,
              ),
              Icon(
                Icons.check_circle_outline,
                color: Colors.green.shade300,
                size: 300,
              ),
              Text(
                "De gegevens zijn succesvol opgeslagen",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ],
          ),
        );

      default:
        return Text("ok");
    }
  }

  //QRCODE CAMERA
  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 200 ||
            MediaQuery.of(context).size.height < 200)
        ? 150.0
        : 200.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      cameraFacing: CameraFacing.front,
      onQRViewCreated: _onQRViewCreated,
      formatsAllowed: [BarcodeFormat.qrcode],
      overlay: QrScannerOverlayShape(
        borderColor: Theme.of(context).primaryColor,
        borderRadius: 10,
        borderLength: 30,
        borderWidth: 10,
        cutOutSize: scanArea,
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      print("Scanned Data Stream!");
      setState(() {
            this.barcodeFound = true;
        result = scanData;
      });
      if(this.barcodeFound && this.selectedBox==null){
        // Search the box with the found MacAddress
        _searchBoxByMacAddress(scanData.code);
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

    // Detail modal of a box with all information
  void _searchBoxModal(context) {
print("Search box modal");
print("Search box modal boxlist length = " + this.boxList.length.toString());
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
                  // height: 900,
                  color: Colors.white,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(25.0, 25.0, 25.0, 5.0),
                    child: Column(
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
                        Padding(padding: EdgeInsets.all(20)),
                                Container(height: 80.0,
            child: Padding(
                padding: EdgeInsets.all(8.0),
                child: TextFieldBOne(
                  context: context,
                  labelText: "Zoek een box",
                  textInputAction: TextInputAction.done,
                  controller: searchBoxController,
                  icon: Icon(Icons.search),
                ))),
                Text("Gevonden boxen (" + this.boxList.length.toString() + "/" + this.originalBoxList.length.toString() + "):"),
                        Container( child: this.boxList.length != 0
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
                        Padding(padding: EdgeInsets.all(20)),
                        // Values of box
                      ],
                    ),
                  ),
                ));
              });
            },

          );
              future.then((void value) => _closeModal(value));

  }

  void _closeModal(void value) {
    print('modal closed');

    // Resume the camera when the modal is closed (on first step)
    if(this.activeStep == 0){
          controller.resumeCamera();

    }

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
                boxText: "",
                box: this.boxList[position],
                onPressed: () {
                  print("Selected box with id: " + this.boxList[position].id.toString());
    setState(() {
this.selectedBox = this.boxList[position];
    });
    Navigator.pop(context);
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


   // Modal to search users
  void _searchUserModal(context) {
print("Search user modal");
print("Search user modal userlist length = " + this.boxList.length.toString());
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
                  // height: 900,
                  color: Colors.white,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(10.0, 25.0, 10.0, 5.0),
                    child: Column(
                      children: [
                                          Text(
                    'Zoek gebruiker',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins',
                    ),
                  ),
                        Padding(padding: EdgeInsets.all(10)),
                                Container(height: 80.0,
            child: Padding(
                padding: EdgeInsets.only(right: 8.0),
                child: TextFieldBOne(
                  context: context,
                  labelText: "Zoek een gebruiker",
                  textInputAction: TextInputAction.done,
                  controller: searchUserController,
                  icon: Icon(Icons.search),
                ))),
                Text("Gevonden gebruikers (" + this.userList.length.toString() + "/" + this.originalUserList.length.toString() + "):"),
                        Container( child: this.userList.length != 0
                          ? _userListItems()
                          : Column(
                              children: <Widget>[
                                Text('Geen resultaten gevonden!'),
                                Expanded(
                                    child: Center(
                                        child: CircularProgressIndicator())),
                              ],
                            ),
                        ),
                        Padding(padding: EdgeInsets.all(20)),
                        // Values of box
                      ],
                    ),
                  ),
                ));
              });
            },

          );
              future.then((void value) => _closeModal(value));
  }

    ListView _userListItems() {
    return new ListView.builder(
      primary: false,
      shrinkWrap: true,
      physics: const AlwaysScrollableScrollPhysics(), // new
      scrollDirection: Axis.vertical,
      // shrinkWrap: true,
      itemCount: this.userList.length,
      itemBuilder: (BuildContext context, int position) {
return               UserListItem(
                user: this.userList[position],
                onPressed: () {
                  print("Selected user with id: " + this.userList[position].id.toString());
    setState(() {
this.selectedUser = this.userList[position];
    });
    Navigator.pop(context);
                },
              );
      },
    );
  }




}
