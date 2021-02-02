import 'package:b_one_project_4_0/widgets/TextFieldBOne.dart';
// import 'package:b_one_project_4_0/widgets/DropDownbOne.dart';
import 'package:b_one_project_4_0/widgets/buttons/BottomAppBarBOne.dart';
import 'package:b_one_project_4_0/widgets/buttons/FlatButtonBOne.dart';
import 'package:b_one_project_4_0/widgets/BoxUserListItem.dart';
import 'package:flutter/material.dart';
import 'package:multi_select_item/multi_select_item.dart';
import 'package:b_one_project_4_0/controller/userController.dart';
import 'package:b_one_project_4_0/controller/snackbarController.dart';
import 'package:b_one_project_4_0/models/user.dart';
import 'package:b_one_project_4_0/models/box.dart';
import 'package:b_one_project_4_0/models/userType.dart';

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

  List<UserType> userTypeList;
  List<Box> boxesList;
  List<String> userTypeNameList = [];

  MultiSelectController controller = new MultiSelectController();

  String dropdownValue = 'One';

  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController postalcodeController = TextEditingController();
  TextEditingController cityController = TextEditingController();

  @override
  void initState() {
    super.initState();
    print("UserID: " + this.id.toString());
    if (id == null) {
      // If there's no id, instantiate the new user, otherwise use the api to fetch the user data
      print("Make new user");
      user = new User(
        firstName: "",
        lastName: "",
        email: "",
        address: "",
        postalCode: "",
        city: "",
        userTypeID: 3,
        userType: new UserType(
            id: 3,
            userTypeName: "Boer"
          ),
      );
    } else {
      _getUser(this.id); // get the user info using the api
    }

    _getAllUserTypes();
  }

  void _getUser(int userID) {
    print("Get user with id: " + id.toString());
    UserController.loadUserByIdWithBoxes(userID).then((result) {
      setState(() {
        print("Show info over: " + result.firstName);
        print("Show info over usertype: " + result.userType.userTypeName);
        print("The amount of boxes of the user: " +
            result.boxes.length.toString());

        this.user = result;
        this.boxesList = result.boxes;

        // Set controllers
        firstnameController.text = result.firstName;
        lastnameController.text = result.lastName;
        emailController.text = result.email;
        addressController.text = result.address;
        postalcodeController.text = result.postalCode;
        cityController.text = result.city;

        controller.disableEditingWhenNoneSelected = true;
        controller.set(this.user.boxes.length);
      });
    });
  }

  void _getAllUserTypes() {
    print("Get all userTypes");
    UserController.loadUserTypes().then((result) {
      setState(() {
        print("Number of userTypes: " + result.length.toString());
        this.userTypeList = result;
        for (UserType userType in result) {
          // print("UsertypeName: " + userType.userTypeName);
          this.userTypeNameList.add(userType.userTypeName);
        }
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

    switch (this.user.userType.userTypeName) {
      case "Admin":
        {
          print("Admin");
          this.user.userTypeID = 1;
        }
        break;

      case "Monteur":
        {
          print("Monteur");
          this.user.userTypeID = 2;
        }
        break;

      case "Boer":
        {
          print("Boer");
          this.user.userTypeID = 3;
        }
        break;

      default:
        {
          print("ERROR");
          //statements;
        }
        break;
    }

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
              child: (user == null || userTypeList == null)
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [Center(child: CircularProgressIndicator())],
                    )
                  : Column(
                      children: [
                        Text(
                          this.user.id != null
                              ? this.user.firstName + ' ' + this.user.lastName
                              : 'Gebruiker toevoegen',
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Poppins',
                          ),
                        ),
                        Padding(padding: EdgeInsets.all(5.0)),
                        if (this.user?.id == null)
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
                          labelText: "E-mail",
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text('Type gebruiker: ', textAlign: TextAlign.left),
                            DropdownButton<String>(
                              value: this.user.userType.userTypeName,
                              icon: Icon(Icons.arrow_downward,
                                  color: Theme.of(context).primaryColor),
                              iconSize: 24,
                              elevation: 16,
                              dropdownColor: Colors.white,
                              underline: Container(
                                height: 2,
                                color: Theme.of(context).primaryColor,
                              ),
                              onChanged: (String newUserTypeValue) {
                                print("UserType changed. Now: " +
                                    newUserTypeValue);
                                setState(() {
                                  this.user.userType.userTypeName =
                                      newUserTypeValue;
                                });
                              },
                              items: this.userTypeNameList != null &&
                                      this.userTypeNameList.isNotEmpty
                                  ? this
                                      .userTypeNameList
                                      .map<DropdownMenuItem<String>>(
                                          (userTypeName) {
                                      return DropdownMenuItem<String>(
                                        value: userTypeName,
                                        child: Text(userTypeName),
                                      );
                                    }).toList()
                                  : <String>['Admin', 'Boer', 'Monteur', '...']
                                      .map<DropdownMenuItem<String>>(
                                          (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text("Boxen van ${this.user.firstName}:"),
                        SizedBox(
                          height: 20,
                        ),
                        this.user.boxes.length > 0
                            ? ListView.builder(
                                primary: false,
                                shrinkWrap: true,
                                physics:
                                    const AlwaysScrollableScrollPhysics(), // new
                                scrollDirection: Axis.vertical,
                                // shrinkWrap: true,
                                itemCount: this.user.boxes.length,
                                itemBuilder:
                                    (BuildContext context, int position) {
                                  return FractionalTranslation(
                                      translation: Offset(0.0, 0.0),
                                      child: Stack(children: <Widget>[
                                        BoxUserListItem(
                                          boxText:
                                              "!!!!!! needs to be replaced",
                                          box: this.user.boxes[position],
                                          onPressed: () {
                                            print("Show box detail model");
                                          },
                                          locationText: "Geel !!!",
                                        ),
                                        Positioned(
                                          // Marble to show active status
                                          top: 10.0,
                                          right: 10.0,
                                          child: Icon(Icons.brightness_1,
                                              size: 15.0,
                                              color: this
                                                      .user
                                                      .boxes[position]
                                                      .active
                                                  ? Colors.green
                                                  : Colors.red),
                                        )
                                      ]));
                                },
                                // itemBuilder: (context, index) {
                                //   return MultiSelectItem(
                                //     isSelecting: controller.isSelecting,
                                //     // The function that will be called when item is long-tapped/tapped
                                //     onSelected: () {
                                //       setState(() {
                                //         controller.toggle(index);
                                //       });
                                //     },
                                //     child: Container(
                                //       child: ListTile(
                                //         title: new Text(
                                //             this.boxesList[index].name),
                                //         subtitle: new Text(
                                //             // "Location ${this.user.boxes[index]['key']}"),
                                //             "Location"),
                                //       ),

                                //       //change color based on wether the id is selected or not.
                                //       decoration:
                                //           controller.isSelected(index)
                                //               ? new BoxDecoration(
                                //                   color: Colors.grey[300])
                                //               : new BoxDecoration(),
                                //     ),
                                //   );
                                // },
                              )
                            : Text("Deze gebruiker heeft geen boxen!"),

                        SizedBox(
                          height: 20,
                        ),
                        // TODO: Think about ban, delete, or end box subscriptions
                        // IconButton(
                        //   icon: Icon(Icons.remove_circle),
                        //   color: Colors.red,
                        //   iconSize: 50,
                        //   onPressed: () {
                        //     print(
                        //         "Show confirmation modal to delete or ban the user");
                        //     _deleteDialog();
                        //   },
                        // ),
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
      bottomNavigationBar: BottomAppBarBOne(active: 1,),
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
