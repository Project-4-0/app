import 'package:b_one_project_4_0/widgets/SafeAreaBOne/safeAreaBOne.dart';
import 'package:b_one_project_4_0/widgets/TextFieldBOne.dart';
import 'package:b_one_project_4_0/widgets/buttons/BottomAppBarBOne.dart';
import 'package:b_one_project_4_0/widgets/buttons/FlatButtonBOne.dart';
import 'package:b_one_project_4_0/models/box.dart';
import 'package:b_one_project_4_0/controller/boxController.dart';
import 'package:b_one_project_4_0/controller/snackbarController.dart';
import 'package:flutter/material.dart';

class BoxDetailPage extends StatefulWidget {
  final int
      id; // UserDetailPage has an id-parameter which contains the id of the user to show
  BoxDetailPage(this.id);

  @override
  _BoxDetailPageState createState() => _BoxDetailPageState(id);
}

class _BoxDetailPageState extends State<BoxDetailPage> {
  int id; // UserDetailPageState has the same id-parameter
  _BoxDetailPageState(this.id);

  Box box;

  TextEditingController macAddressController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController commentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getBox(this.id); // get the box info using the api
  }

  void _getBox(int id) {
    BoxController.loadBoxAll(id).then((result) {
      setState(() {
        box = result;
      });
      print("Detial of box: " + result.name);
      // Set controllers
      macAddressController.text = result.macAddress;
      nameController.text = result.name;
      commentController.text = result.comment;
    });
  }

  void _saveBox() {
    this.box.macAddress = macAddressController.text;
    commentController.text == ""
        ? this.box.comment = null
        : this.box.comment = commentController.text;
    this.box.name = nameController.text;

    BoxController.updateBox(this.box).then((response) {
      if (response != null) {
        SnackBarController().show(
            text: "Box \'" + response.name + "\' is geupdated!",
            title: "Update",
            type: "GOOD");
      }
    });

    // print("Comment by box:" + commentController.text + "Is een spatie?");
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
                    this.box != null ? this.box.name : 'Box',
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
                  if (this.box != null)
                    Column(children: [
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
                    ]),
                  SizedBox(
                    height: 20,
                  ),
                  FlatButtonBOne(
                    minWidth: double.infinity,
                    text: "Opslaan",
                    onPressed: () {
                      _saveBox();
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
