import 'dart:io';
import 'package:b_one_project_4_0/widgets/SafeAreaBOne/safeAreaBOne.dart';
import 'package:b_one_project_4_0/widgets/TextFieldBOne.dart';
import 'package:b_one_project_4_0/widgets/buttons/BottomAppBarBOne.dart';
import 'package:b_one_project_4_0/widgets/buttons/DashboardButtonsOverview.dart';
import 'package:b_one_project_4_0/widgets/buttons/FlatButtonBOne.dart';
import 'package:b_one_project_4_0/widgets/buttons/OutlineFlatButtonBOne.dart';
import 'package:b_one_project_4_0/widgets/BoxListItem.dart';
import 'package:b_one_project_4_0/widgets/UserListItem.dart';
import 'package:b_one_project_4_0/widgets/location_map.dart';
import 'package:b_one_project_4_0/controller/boxController.dart';
import 'package:b_one_project_4_0/controller/userController.dart';
import 'package:b_one_project_4_0/controller/snackbarController.dart';
import 'package:b_one_project_4_0/models/box.dart';
import 'package:b_one_project_4_0/models/user.dart';
import 'package:b_one_project_4_0/pages/monteur/newUser.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:im_stepper/stepper.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:geolocator/geolocator.dart';

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

  // Location controllers
  TextEditingController latController = TextEditingController();
  TextEditingController lngController = TextEditingController();

  TextEditingController boxCommentController = TextEditingController();

  // Must be used to control the upper bound of the activeStep variable. Please see next button below the build() method!
  int upperBound = 0;

  double userPositionLat;
  double userPositionLng;

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
      controller?.pauseCamera();
    } else if (Platform.isIOS) {
      controller?.resumeCamera();
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
    controller?.pauseCamera();

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

  void _connectBoxUser() {
    print("Connect the selected box with the selected user");

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

  void _getUserLocation() async {
    var position = await GeolocatorPlatform.instance
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    print(position.latitude.toString());
    setState(() {
      this.userPositionLat = position.latitude;
      this.userPositionLng = position.longitude;
    });
    if (this.userPositionLat != null && this.userPositionLng != null) {
      SnackBarController().show(
          text: "Uw huidige locatie is: \'" +
              this.userPositionLat.toString() +
              " - " +
              this.userPositionLat.toString() +
              "\'.\nDeze locatie representeert de locatie van de box.",
          title: "Huidige locatie",
          type: "INFO");
    }
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
          .where((user) => user.address == null
              ? (user.firstName
                      .toLowerCase()
                      .contains(searchUserController.text.toLowerCase()) ||
                  user.lastName
                      .toLowerCase()
                      .contains(searchUserController.text.toLowerCase()) ||
                  user.email
                      .toLowerCase()
                      .contains(searchUserController.text.toLowerCase()))
              : (user.firstName
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
                      .contains(searchUserController.text.toLowerCase())))
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
    // controller?.pauseCamera();

    BoxController.loadBoxWithMacAddress(macAddress).then((result) {
      setState(() {
        this.selectedBox = result;
        this.boxCommentController.text = result.comment;
        SnackBarController().show(
            text: "De box: \"" +
                this.selectedBox.name +
                "\" is geselecteerd om te koppelen",
            title: "Box geselecteerd",
            type: "INFO");
      });
    });
  }

  void _createBoxUser() {
    print(
        "Create the box - user relation & update the box if the comment is changed");

    // Update the box if the comment is changed
    if (this.boxCommentController.text != this.selectedBox.comment) {
      print("The comment of the box is changed");
      this.selectedBox.comment = this.boxCommentController.text;
      BoxController.updateBox(this.selectedBox).then((result) {
        if (result != null) {
          print("The comment of the box is updated");
        }
      });
    }
    // TODO: check the lat and lng
    UserController.addBoxUser(this.selectedUser.id, this.selectedBox.id,
            this.userPositionLat, this.userPositionLng)
        .then((result) {
      if (activeStep < upperBound && result != null) {
        SnackBarController().show(
            text: this.selectedUser.firstName +
                " " +
                this.selectedUser.lastName +
                " is gekoppeld met: " +
                this.selectedBox.name +
                "!",
            title: "Koppelen",
            type: "GOOD");
        setState(() {
          activeStep++;
        });
      }
    });
  }

  Future<void> _registerNewUser() async {
    User result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NewUserMonteurPage()),
    );
    if (result != null) {
      print("Back from new user monteur");
      print("Result name:" + result.firstName);
      setState(() {
        this.selectedUser = result;
        SnackBarController().show(
            text: "De nieuwe gebruiker: \"" +
                this.selectedUser.firstName +
                " " +
                this.selectedUser.lastName +
                "\" is geselecteerd om te koppelen",
            title: "Gebruiker geselecteerd",
            type: "INFO");
      });
    }
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
                        Icons.add_location,
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
                ],
              ),
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

  /// Returns the next button.
  Widget nextButton() {
    return FlatButtonBOne(
      text: "Volgende",
      onPressed: (this.activeStep == 0 && this.selectedBox == null)
          ? null
          : (this.activeStep == 1 && this.selectedUser == null)
              ? null
              : (this.activeStep == 2 &&
                      this.userPositionLat == null &&
                      this.userPositionLng == null)
                  ? null
                  : () {
                      if (activeStep < upperBound) {
                        setState(() {
                          activeStep++;
                        });
                      }
                    },
//             onPressed:
//       () {
//                 if (activeStep == 0) {
// controller?.pauseCamera();
//         }
//         if (activeStep < upperBound) {
//           setState(() {
//             activeStep++;
//           });
//         }
//       },
    );
  }

  /// Create the userBox
  Widget createButton() {
    return FlatButtonBOne(
      text: "Koppelen",
      onPressed: () {
        _createBoxUser();
      },
    );
  }

  /// Returns the previous button.
  Widget previousButton() {
    return FlatButtonBOne(
      text: "Terug",
      onPressed: this.activeStep == 0
          ? null
          : () {
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
                    // flex: 1,
                    child: FlatButtonBOne(
                      minWidth: double.infinity,
                      text: "Handmatig zoeken",
                      onPressed: () {
                        print("Box handmatig zoeken");
                        _getBoxes(); // Get all the boxes to search manually and open the search modal
                      },
                    ),
                  ),
                  if (this.selectedBox != null)
                    Column(children: [
                      Padding(padding: EdgeInsets.only(top: 30)),
                      Text("Geselecteerde box:"),
                      BoxListItem(
                        box: selectedBox,
                        onPressed: null,
                      ),
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          print("DeleteSelectedBox!");
                          setState(() {
                            this.selectedBox = null;
                            this.boxCommentController.text = null;
                            this.barcodeFound = false;
                          });
                          SnackBarController().show(
                              text: "Selecteer een nieuwe box om te koppelen",
                              title: "Selecteer box",
                              type: "INFO");
                          controller?.pauseCamera();
                          controller?.resumeCamera();
                        },
                      ),
                    ])
                ],
              ),
            ),
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
                text: "Registreren",
                onPressed: () {
                  print("Add new user");
                  _registerNewUser();
                },
                icon: Icons.group_add,
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
              if (this.selectedUser != null)
                Column(children: [
                  Padding(padding: EdgeInsets.only(top: 20)),
                  Text("Geselecteerde gebruiker:"),
                  UserListItem(
                    user: selectedUser,
                    showTrailingIcon: false,
                    onPressed: null,
                  ),
                  IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      print("DeleteSelectedUser!");
                      setState(() {
                        this.selectedUser = null;
                      });
                      SnackBarController().show(
                          text:
                              "Selecteer of registreer een gerbuiker om te koppelen",
                          title: "Selecteer gebruiker",
                          type: "INFO");
                    },
                  ),
                ]),
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
        );
      // Location
      case 2:
        return Padding(
            padding: const EdgeInsets.only(top: 30),
            // child: this.selectedBox != null && this.selectedUser != null
            child:
                // ?
                Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "Locatie",
                  style: Theme.of(context).textTheme.bodyText2,
                  textAlign: TextAlign.center,
                ),
                // If the user location is unknown
                if (this.userPositionLat == null &&
                    this.userPositionLng == null)
                  Column(children: [
                    SizedBox(
                      height: 20,
                    ),
                    // This is shown in a popup
                    // Text(
                    //     "De locatie van uw toestel zal gebruikt worden om de locatie van de box te bepalen.",
                    //     textAlign: TextAlign.justify,
                    //     style: TextStyle(fontWeight: FontWeight.w400)),
                    // SizedBox(
                    //   height: 10,
                    // ),
                    // Text(
                    //     "Ga op de plaats van de box staan en houdt uw toestel stil voor een zo nauwkeurig mogelijke locatiebepaling.",
                    //     textAlign: TextAlign.justify,
                    //     style: TextStyle(fontWeight: FontWeight.w400)),
                    FlatButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) =>
                              _buildPopupDialogLocatie(context),
                        );
                      },
                      child: Text("Meer info over automatische locatie",
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 16,
                          )),
                    ),

                    DashboardButtonsOverview(
                      minWidth: double.infinity,
                      text: "Automatisch toevoegen",
                      onPressed: () {
                        print("Vraag de huidige locatie van de gerbuiker op!");
                        _getUserLocation();
                      },
                      icon: Icons.add_location,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    DashboardButtonsOverview(
                      minWidth: double.infinity,
                      text: "Handmatig toevoegen",
                      onPressed: () {
                        print("Handmatig locatie invoeren");
                        _addLocationMannually(context);
                      },
                      icon: Icons.add_location_alt,
                    ),
                  ]),
                // If the user location is known
                if (this.userPositionLat != null &&
                    this.userPositionLng != null)
                  Column(children: [
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                        height: 250.0,
                        child: LocationMap(
                            this.userPositionLat, this.userPositionLng)),
                    IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        print("Delete Location!");
                        setState(() {
                          // Reset the locations of the user
                          this.userPositionLat = null;
                          this.userPositionLng = null;
                        });
                        SnackBarController().show(
                            text:
                                "Voeg een nieuwe locatie toe om een box koppelen",
                            title: "Locatie verwijderd",
                            type: "INFO");
                      },
                    ),
                  ]),
                SizedBox(
                  height: 20,
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
            )
            // : Center(child: Text("Selecteer een box en een gebruiker!")),
            );
      // Overview + opmerking
      case 3:
        return Padding(
          padding: const EdgeInsets.only(top: 30),
          child: this.selectedBox != null &&
                  this.selectedUser != null &&
                  this.userPositionLat != null &&
                  this.userPositionLng != null
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      "Bevestigen",
                      style: Theme.of(context).textTheme.bodyText2,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text("Box:", textAlign: TextAlign.left),
                    BoxListItem(
                      box: this.selectedBox,
                      onPressed: null,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFieldBOne(
                      context: context,
                      icon: Icon(Icons.insert_comment),
                      labelText: "Opmerking:",
                      controller: boxCommentController,
                      keyboardType: TextInputType.multiline,
                      maxLength: 200,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text("Locatie:", textAlign: TextAlign.left),
                    Container(
                        height: 150.0,
                        child: LocationMap(
                            this.userPositionLat, this.userPositionLng)),
                    SizedBox(
                      height: 10,
                    ),
                    Text("Gebruiker:", textAlign: TextAlign.left),
                    UserListItem(
                      user: this.selectedUser,
                      showTrailingIcon: false,
                      onPressed: null,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        previousButton(),
                        createButton(),
                      ],
                    ),
                  ],
                )
              : Center(
                  child: Text("Selecteer een box, locatie en een gebruiker!")),
        );
      // Confirmation
      case 4:
        return Padding(
          padding: const EdgeInsets.only(top: 30),
          child: this.selectedBox != null &&
                  this.selectedUser != null &&
                  this.userPositionLat != null &&
                  this.userPositionLng != null
              ? Column(
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
                      "De gegevens zijn succesvol opgeslagen!",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                            child: FlatButtonBOne(
                          text: "Dashboard",
                          onPressed: () {
                            Navigator.pushNamedAndRemoveUntil(
                                context, '/dashboard', (route) => false);
                            setState(() {
                              activeStep = 0;
                            });
                          },
                        )),
                      ],
                    ),
                  ],
                )
              : Center(
                  child: Text("Selecteer een box, locatie en een gebruiker!")),
        );

      default:
        return Text("Er ging iets mis!");
    }
  }

  Widget _buildPopupDialogLocatie(BuildContext context) {
    return new AlertDialog(
      title: const Text('Automatische locatie'),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
              "De locatie van uw toestel zal gebruikt worden om de locatie van de box te bepalen.",
              textAlign: TextAlign.justify,
              style: TextStyle(fontWeight: FontWeight.w400)),
          SizedBox(
            height: 10,
          ),
          Text(
              "Ga op de plaats van de box staan en houd uw toestel stil voor een zo nauwkeurig mogelijke locatiebepaling te verkrijgen.",
              textAlign: TextAlign.justify,
              style: TextStyle(fontWeight: FontWeight.w400)),
        ],
      ),
      actions: <Widget>[
        new FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          textColor: Theme.of(context).primaryColor,
          child: const Text('Close'),
        ),
      ],
    );
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
      if (this.barcodeFound && this.selectedBox == null) {
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
    print(
        "Search box modal boxlist length = " + this.boxList.length.toString());
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
            // height: 900,
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
                  Padding(padding: EdgeInsets.all(20)),
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

    // Resume the camera when the modal is closed (on first step) if there is no selected box
    if (this.activeStep == 0 && this.selectedBox == null) {
      print("Resume the camera");
      controller?.resumeCamera();
    }
  }

  void _closeModalUser(void value) {
    print('UserModal closed');
  }

  void _closeModalLocation(void value) {
    // Empty the controllers after closing the modal
    this.latController.clear();
    this.lngController.clear();
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
                  // !!!!!
                  print("Selected box with id: " +
                      this.boxList[position].id.toString());
                  setState(() {
                    this.selectedBox = this.boxList[position];
                    this.boxCommentController.text =
                        this.boxList[position].comment;
                  });
                  controller?.pauseCamera();
                  Navigator.pop(context);
                  SnackBarController().show(
                      text: "De box: \"" +
                          this.selectedBox.name +
                          "\" is geselecteerd om te koppelen",
                      title: "Box geselecteerd",
                      type: "INFO");
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

  // Modal to search users
  void _searchUserModal(context) {
    print("Search user modal");
    print("Search user modal userlist length = " +
        this.boxList.length.toString());
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
            color: Theme.of(context).scaffoldBackgroundColor,
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
                  Container(
                      height: 80.0,
                      child: Padding(
                          padding: EdgeInsets.only(right: 8.0),
                          child: TextFieldBOne(
                            context: context,
                            labelText: "Zoek een gebruiker",
                            textInputAction: TextInputAction.done,
                            controller: searchUserController,
                            icon: Icon(Icons.search),
                          ))),
                  Text("Gevonden gebruikers (" +
                      this.userList.length.toString() +
                      "/" +
                      this.originalUserList.length.toString() +
                      "):"),
                  Container(
                    child: this.userList.length != 0
                        ? _userListItems()
                        : Column(
                            children: <Widget>[
                              Text('Geen resultaten gevonden!'),
                              Text(
                                'Geen resultaten gevonden!\nProbeer een andere zoekterm.',
                                textAlign: TextAlign.center,
                              ),
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
    future.then((void value) => _closeModalUser(value));
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
        return UserListItem(
          user: this.userList[position],
          showTrailingIcon: true,
          onPressed: () {
            print("Selected user with id: " +
                this.userList[position].id.toString());
            setState(() {
              this.selectedUser = this.userList[position];
            });
            Navigator.pop(context);
            SnackBarController().show(
                text: "De gebruiker: \"" +
                    this.selectedUser.firstName +
                    " " +
                    this.selectedUser.lastName +
                    "\" is geselecteerd om te koppelen",
                title: "Gebruiker geselecteerd",
                type: "INFO");
          },
        );
      },
    );
  }

  // Detail modal of a location with all information
  void _addLocationMannually(context) {
    print("Add location mannually");
    Future<void> future = showModalBottomSheet<void>(
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
            padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 5.0),
            // height: 900,
            color: Theme.of(context).scaffoldBackgroundColor,
            child: Padding(
              padding: EdgeInsets.fromLTRB(25.0, 25.0, 25.0, 5.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Locatie toevoegen',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(20)),
                  TextFieldBOne(
                      context: context,
                      labelText: "Latitude",
                      icon: Icon(Icons.explore),
                      controller: latController,
                      keyboardType: TextInputType.number),
                  SizedBox(
                    height: 20,
                  ),
                  TextFieldBOne(
                    context: context,
                    labelText: "Longtitude",
                    icon: Icon(Icons.explore),
                    controller: lngController,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.done,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: OutlineFlatButtonBOne(
                        text: "Opslaan",
                        onPressed: latController.text.isEmpty &&
                                lngController.text.isEmpty
                            ? null
                            : () {
                                print("Pressed button to add location");
                                setState(() {
                                  this.userPositionLat =
                                      double.parse(latController.text);
                                  this.userPositionLng =
                                      double.parse(lngController.text);
                                });
                                Navigator.pop(
                                    context); // Close the bottom modal
                                SnackBarController().show(
                                    text: "Uw huidige locatie is: \'" +
                                        this.userPositionLat.toString() +
                                        " - " +
                                        this.userPositionLat.toString() +
                                        "\'.\nDeze locatie representeert de locatie van de box.",
                                    title: "Handmatige locatie",
                                    type: "INFO");
                              }),
                  ),
                  Padding(padding: EdgeInsets.all(20)),
                ],
              ),
            ),
          ));
        });
      },
    );
    future.then((void value) => _closeModalLocation(value));
  }
}
