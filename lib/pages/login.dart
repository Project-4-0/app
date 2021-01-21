import 'package:b_one_project_4_0/widgets/CardBOne.dart';
import 'package:b_one_project_4_0/widgets/TextFieldBOne.dart';
import 'package:b_one_project_4_0/widgets/buttons/BottomAppBarBOne.dart';
import 'package:b_one_project_4_0/widgets/buttons/FlatButtonBOne.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
                  Padding(padding: EdgeInsets.all(5.0)),
                  Image(
                    image: AssetImage("assets/logo_vito_colorful.png"),
                    height: 150,
                  ),
                  Text(
                    "Welkom!",
                    style: TextStyle(
                      fontSize: 50,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: 60,
                  ),
                  TextFieldBOne(
                    context: context,
                    labelText: "E-mail",
                    icon: Icon(Icons.person_outline),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFieldBOne(
                    context: context,
                    labelText: "wachtwoord",
                    icon: Icon(Icons.lock),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  FlatButtonBOne(
                    minWidth: double.infinity,
                    text: "Aanmelden",
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      // floatingActionButton: FloatingActionButtonBOne(),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // bottomNavigationBar: BottomAppBarBOne(),
    );
  }
}
