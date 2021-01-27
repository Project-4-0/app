import 'package:b_one_project_4_0/widgets/TextFieldBOne.dart';
import 'package:b_one_project_4_0/widgets/buttons/BottomAppBarBOne.dart';
import 'package:b_one_project_4_0/widgets/buttons/FlatButtonBOne.dart';
import 'package:flutter/material.dart';
import 'package:multi_select_item/multi_select_item.dart';
import 'package:b_one_project_4_0/controller/userController.dart';
import 'package:b_one_project_4_0/controller/snackbarController.dart';
import 'package:b_one_project_4_0/models/user.dart';

class UserDetailPage extends StatefulWidget {
  final int
      id; // UserDetailPage has an id-parameter which contains the id of the user to show
  UserDetailPage(this.id);

  @override
  _UserDetailPageState createState() => _UserDetailPageState(id);
}

class _UserDetailPageState extends State<UserDetailPage> {
  int id; // UserDetailPageState has the same id-parameter
  _UserDetailPageState(this.id);

  User user;

  List mainList =
      new List(); // TODO: Replace by list of boxes with a distinction between available, unavailble and owned boxes!
  MultiSelectController controller = new MultiSelectController();

  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController postalcodeController = TextEditingController();
  TextEditingController cityController = TextEditingController();

  @override
  void initState() {
    super.initState();
    print(id.toString());
    if (id == null) {
      // If there's no id, instantiate the new user, otherwise use the api to fetch the user data
      user = new User(
        firstName: "",
        lastName: "",
        email: "",
        address: "",
        postalCode: "",
        city: "",
        userTypeID: null,
      );
    } else {
      _getUser(id); // get the user info using the api
    }

    mainList.add({"key": "1"});
    mainList.add({"key": "2"});
    mainList.add({"key": "3"});
    mainList.add({"key": "4"});

    controller.disableEditingWhenNoneSelected = true;
    controller.set(mainList.length);
  }

  void _getUser(int userID) {
    print("Get user with id: " + id.toString());
    UserController.loadUserById(userID).then((result) {
      setState(() {
        print("Show info over" + result.firstName);

        this.user = result;

        //set controllers
        firstnameController.text = result.firstName;
        lastnameController.text = result.lastName;
        emailController.text = result.email;
        addressController.text = result.address;
        postalcodeController.text = result.postalCode;
        cityController.text = result.city;
      });
    });
  }

  _setUserProfile() {
    print("SetUserProfile");
    // Set User with updated values
    this.user.firstName = firstnameController.text;
    this.user.lastName = lastnameController.text;
    this.user.email = emailController.text;
    this.user.address = addressController.text;
    this.user.postalCode = postalcodeController.text;
    this.user.city = cityController.text;

    UserController.setUser(this.user).then((response) {
      if (response) {
        SnackBarController().show(
            text: "Wijzigingen zijn succesvol opgeslagen",
            title: "Update",
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
            padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 80.0),
            child: Center(
              child: Column(
                children: [
                  Text(
                    'Gebruiker toevoegen',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(5.0)),
                  Icon(
                    Icons.person_add,
                    size: 50,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFieldBOne(
                    context: context,
                    labelText: "Voornaam",
                    icon: Icon(Icons.person_outline),
                    controller: firstnameController,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFieldBOne(
                    context: context,
                    labelText: "Achternaam",
                    icon: Icon(Icons.person_outline),
                    controller: lastnameController,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFieldBOne(
                    context: context,
                    labelText: "Email",
                    icon: Icon(Icons.mail_outline),
                    controller: emailController,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFieldBOne(
                    context: context,
                    labelText: "Straat",
                    icon: Icon(Icons.location_on_outlined),
                    controller: addressController,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Flexible(
                          child: TextFieldBOne(
                        context: context,
                        labelText: "Gemeente",
                        icon: Icon(Icons.account_balance_outlined),
                        controller: cityController,
                      )),
                      SizedBox(
                        width: 10,
                      ),
                      Flexible(
                        child: TextFieldBOne(
                          context: context,
                          labelText: "Postcode",
                          icon: Icon(Icons.apartment_outlined),
                          controller: postalcodeController,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text("Boxen:"),
                  SizedBox(
                      height: 200,
                      child: Container(
                          color: Colors.white,
                          child: ListView.builder(
                            itemCount: mainList.length,
                            itemBuilder: (context, index) {
                              return MultiSelectItem(
                                isSelecting: controller.isSelecting,
                                // The function that will be called when item is long-tapped/tapped
                                onSelected: () {
                                  setState(() {
                                    controller.toggle(index);
                                  });
                                },
                                child: Container(
                                  child: ListTile(
                                    title: new Text(
                                        "Box ${mainList[index]['key']}"),
                                    subtitle: new Text(
                                        "Location ${mainList[index]['key']}"),
                                  ),

                                  //change color based on wether the id is selected or not.
                                  decoration: controller.isSelected(index)
                                      ? new BoxDecoration(
                                          color: Colors.grey[300])
                                      : new BoxDecoration(),
                                ),
                              );
                            },
                          ))),
                  SizedBox(
                    height: 20,
                  ),
                  IconButton(
                    icon: Icon(Icons.remove_circle),
                    color: Colors.red,
                    iconSize: 50,
                    onPressed: () {
                      print(
                          "Show confirmation modal to delete or ban the user");
                      _deleteDialog();
                    },
                  ),
                  FlatButtonBOne(
                    minWidth: double.infinity,
                    text: "Opslaan",
                    onPressed: () {
                      print("Save user");
                      _setUserProfile();
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
      bottomNavigationBar: BottomAppBarBOne(),
    );
  }

  Future<void> _deleteDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // close when tappen out of dialog
      builder: (BuildContext context) {
        return AlertDialog(
          // title: Text('Delete ' +
          //     firstnameController.text +
          //     " " +
          //     lastnameController.text),
          title: Text("Delete ...."),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                // Text('Are you sure you want to delete: \'' +
                //     firstnameController.text +
                //     " " +
                //     lastnameController.text +
                //     '\' ?'),
                Text('Are you sure you want to delete: \'' + " ... " + '\' ?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Yes'),
              onPressed: () {
                Navigator.of(context).pop();
                print("Delete the user!");
                // _deleteUser();
              },
            ),
            TextButton(
              child: Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
                print("Don't delete the user!");
              },
            ),
          ],
        );
      },
    );
  }
}
