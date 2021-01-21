import 'dart:ffi';
import 'dart:io';

import 'package:b_one_project_4_0/widgets/CardBOne.dart';
import 'package:b_one_project_4_0/widgets/TextFieldBOne.dart';
import 'package:b_one_project_4_0/widgets/buttons/BottomAppBarBOne.dart';
import 'package:b_one_project_4_0/widgets/buttons/DashboardButtonsOverview.dart';
import 'package:b_one_project_4_0/widgets/buttons/FlatButtonBOne.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:im_stepper/stepper.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class MonteurConnectedPage extends StatefulWidget {
  @override
  _MonteurConnectedPageState createState() => _MonteurConnectedPageState();
}

class _MonteurConnectedPageState extends State<MonteurConnectedPage> {
  int activeStep = 0; // Initial step set to 5.

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
    if (Platform.isAndroid) {
      controller.pauseCamera();
    } else if (Platform.isIOS) {
      controller.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(20.0),
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
      bottomNavigationBar: BottomAppBarBOne(),
    );
  }

  /// Returns the next button.
  Widget nextButton() {
    return FlatButtonBOne(
      text: "Volgend",
      onPressed: () {
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
      onPressed: () {
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
                        if (result != null)
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
                      text: "Handmatisch zoeken",
                      onPressed: null,
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
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
                onPressed: () {},
                icon: Icons.group,
              ),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        );

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
      setState(() {
        result = scanData;
      });
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
