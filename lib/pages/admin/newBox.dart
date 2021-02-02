import 'package:b_one_project_4_0/widgets/SafeAreaBOne/safeAreaBOne.dart';
import 'package:b_one_project_4_0/widgets/TextFieldBOne.dart';
import 'package:b_one_project_4_0/widgets/buttons/BottomAppBarBOne.dart';
import 'package:b_one_project_4_0/widgets/buttons/FlatButtonBOne.dart';
import 'package:b_one_project_4_0/models/box.dart';
import 'package:b_one_project_4_0/controller/boxController.dart';
import 'package:b_one_project_4_0/controller/snackBarController.dart';
import 'package:flutter/material.dart';

class NewBoxPage extends StatefulWidget {
  @override
  _NewBoxPageState createState() => _NewBoxPageState();
}

class _NewBoxPageState extends State<NewBoxPage> {
  Box box;

  TextEditingController macAddressController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController commentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    box = new Box(
      macAddress: "",
      name: "",
      comment: null,
      active: true,
    );
  }

  _createBox() {
    print("Create Box");

    // Set Box with new values
    this.box.macAddress = macAddressController.text;
    this.box.name = nameController.text;
    this.box.comment = commentController.text;

    BoxController.createBox(this.box).then((response) {
      if (response != null) {
        SnackBarController().show(
            text: "Nieuwe box \'" + response.name + "\' is aangemaakt!",
            title: "Aangemaakt",
            type: "GOOD");
      }
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
                    'Box',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(5.0)),
                  Icon(
                    Icons.business_center,
                    size: 100,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  // Mac address of box needs to be givin if the box is manually inserted in db
                  TextFieldBOne(
                    context: context,
                    labelText: "MAC-adres",
                    icon: Icon(Icons.dialpad),
                    controller: macAddressController,
                    keyboardType: TextInputType.datetime,
                    textInputAction: TextInputAction.next,
                    textCapitalization: TextCapitalization.sentences,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFieldBOne(
                    context: context,
                    labelText: "Naam",
                    icon: Icon(Icons.business_center),
                    controller: nameController,
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    textCapitalization: TextCapitalization.sentences,
                    maxLength: 12,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFieldBOne(
                    context: context,
                    labelText: "Opmerking",
                    icon: Icon(Icons.comment),
                    controller: commentController,
                    keyboardType: TextInputType.multiline,
                    textInputAction: TextInputAction.next,
                    textCapitalization: TextCapitalization.sentences,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('Actief:', textAlign: TextAlign.center),
                      if (box.active != null)
                        SizedBox(
                            width: 80.0,
                            height: 50.0,
                            child: Switch(
                              value: box.active,
                              onChanged: (value) {
                                setState(() {
                                  box.active = value;
                                  print(box.active);
                                });
                              },
                              activeTrackColor: Theme.of(context).primaryColor,
                              activeColor: Theme.of(context).primaryColor,
                            )),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  FlatButtonBOne(
                    minWidth: double.infinity,
                    text: "Opslaan",
                    onPressed: () {
                      print("Create box!");
                      _createBox();
                    },
                  ),
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
}
