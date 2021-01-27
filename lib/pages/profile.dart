import 'package:b_one_project_4_0/controller/snackbarController.dart';
import 'package:b_one_project_4_0/controller/userController.dart';
import 'package:b_one_project_4_0/models/user.dart';
import 'package:b_one_project_4_0/widgets/SafeAreaBOne/safeAreaBOne.dart';
import 'package:b_one_project_4_0/widgets/TextFieldBOne.dart';
import 'package:b_one_project_4_0/widgets/buttons/BottomAppBarBOne.dart';
import 'package:b_one_project_4_0/widgets/buttons/FlatButtonBOne.dart';
import 'package:b_one_project_4_0/widgets/buttons/DashboardButtonsOverview.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  User _user;

  //input fields
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController postalcodeController = TextEditingController();
  TextEditingController cityController = TextEditingController();

  @override
  void initState() {
    super.initState();
    //load User
    _getUserProfile();
  }

  _getUserProfile() {
    UserController.loadUser().then((user) {
      setState(() {
        this._user = user;

        //set controllers
        firstnameController.text = this._user.firstName;
        lastnameController.text = this._user.lastName;
        emailController.text = this._user.email;
        addressController.text = this._user.address;
        postalcodeController.text = this._user.postalCode;
        cityController.text = this._user.city;
      });
    });
  }

  _setUserProfile() {
    //set User
    this._user.firstName = firstnameController.text;
    this._user.lastName = lastnameController.text;
    this._user.email = emailController.text;
    this._user.address = addressController.text;
    this._user.postalCode = postalcodeController.text;
    this._user.city = cityController.text;

    UserController.setUser(this._user).then((response) {
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
            padding: safeAreaBOne(),
            child: Center(
              child: Column(
                children: [
                  Text(
                    'Profiel',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(5.0)),
                  Icon(
                    Icons.account_circle,
                    size: 100,
                  ),
                  _inputField(),
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

  _inputField() {
    // view page
    if (_user == null) {
      return CircularProgressIndicator();
    } else {
      return Column(
        children: [
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
                  labelText: "Huisnr.",
                  icon: Icon(Icons.house_outlined),
                ),
              ),
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
          TextFieldBOne(
            context: context,
            labelText: "Gemeente",
            icon: Icon(Icons.account_balance_outlined),
            controller: cityController,
          ),
          SizedBox(
            height: 20,
          ),
          FlatButtonBOne(
            minWidth: double.infinity,
            text: "Opslaan",
            onPressed: () {
              _setUserProfile();
            },
          ),
        ],
      );
    }
  }
}
