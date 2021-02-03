import 'package:b_one_project_4_0/widgets/TextFieldBOne.dart';
import 'package:b_one_project_4_0/widgets/buttons/BottomAppBarBOne.dart';
import 'package:b_one_project_4_0/widgets/buttons/FlatButtonBOne.dart';
import 'package:flutter/material.dart';
import 'package:b_one_project_4_0/controller/userController.dart';
import 'package:b_one_project_4_0/controller/snackbarController.dart';
import 'package:b_one_project_4_0/models/user.dart';

class NewUserMonteurPage extends StatefulWidget {
  NewUserMonteurPage();

  @override
  _NewUserMonteurPageState createState() => _NewUserMonteurPageState();
}

class _NewUserMonteurPageState extends State<NewUserMonteurPage> {
  User user;

  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController postalcodeController = TextEditingController();
  TextEditingController cityController = TextEditingController();

  @override
  void initState() {
    super.initState();
    user = new User(
      firstName: "",
      lastName: "",
      email: "",
      address: "",
      postalCode: "",
      city: "",
      userTypeID: 3, // Monteur can only make new boeren
    );
    //     user = new User(
    //   firstName: "Jill",
    //   lastName: "Van Rethij",
    //   email: "jilleke123gmail.com",
    //   address: "Rodekruisstraat 95B",
    //   postalCode: "2260",
    //   city: "Westerlo",
    //   userTypeID: 3, // Monteur can only make new boeren
    // );
  }

  _saveNewUserPofile() {
    print("SaveUserProfile");
    // Set User with new values

    this.user.firstName = firstnameController.text;
    this.user.lastName = lastnameController.text;
    this.user.email = emailController.text;
    this.user.password = passwordController.text;
    this.user.address = addressController.text;
    this.user.postalCode = postalcodeController.text;
    this.user.city = cityController.text;

    UserController.newUser(this.user).then((response) {
      if (response != null) {
        // Navigate back to the connect page
        Navigator.pop(context, this.user);
        SnackBarController().show(
            text: "Nieuwe gebruiker \'" +
                response.firstName +
                " " +
                response.lastName +
                "\' is aangemaakt!",
            title: "Registratie",
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
              child: (user == null)
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
                          height: 10,
                        ),
                        TextFieldBOne(
                          context: context,
                          labelText: "Achternaam",
                          icon: Icon(Icons.person_outline),
                          controller: lastnameController,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFieldBOne(
                          context: context,
                          labelText: "E-mail",
                          icon: Icon(Icons.mail_outline),
                          controller: emailController,
                          textCapitalization: TextCapitalization.none,
                          keyboardType: TextInputType.emailAddress,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFieldBOne(
                          controller: passwordController,
                          context: context,
                          labelText: "Wachtwoord",
                          keyboardType: TextInputType.visiblePassword,
                          icon: Icon(Icons.lock),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFieldBOne(
                          context: context,
                          labelText: "Straat",
                          icon: Icon(Icons.location_on_outlined),
                          controller: addressController,
                        ),
                        SizedBox(
                          height: 10,
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
                                maxLength: 4,
                                labelText: "Postcode",
                                icon: Icon(Icons.apartment_outlined),
                                controller: postalcodeController,
                                keyboardType: TextInputType.number,
                                textInputAction: TextInputAction.done,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        // TODO: Create list of available boxes
                        SizedBox(
                          height: 20,
                        ),
                        FlatButtonBOne(
                            minWidth: double.infinity,
                            text: "Opslaan",
                            onPressed: () {
                              print("Save user");
                              _saveNewUserPofile();
                            }),
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
