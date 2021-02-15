import 'package:b_one_project_4_0/controller/snackbarController.dart';
import 'package:b_one_project_4_0/controller/userController.dart';
import 'package:b_one_project_4_0/widgets/SafeAreaBOne/safeAreaBOne.dart';
import 'package:b_one_project_4_0/widgets/TextFieldBOne.dart';
import 'package:b_one_project_4_0/widgets/buttons/FlatButtonBOne.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void _login() {
    UserController.login(
            email: emailController.text, password: passwordController.text)
        .then((result) async {
      if (result) {
        SnackBarController()
            .show(text: "U bent ingelogd", title: "Login", type: "GOOD");
        await new Future.delayed(const Duration(seconds: 1));

        Navigator.pushNamedAndRemoveUntil(
            context, '/dashboard', (route) => false);
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

                  _inputForm(),
                  
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _inputForm() {
    return Column(
      children: [
        SizedBox(
          height: 60,
        ),
        TextFieldBOne(
          controller: emailController,
          context: context,
          labelText: "E-mail",
          icon: Icon(Icons.person_outline),
          keyboardType: TextInputType.emailAddress,
          textCapitalization: TextCapitalization.none,
        ),
        SizedBox(
          height: 20,
        ),
        TextFieldBOne(
          controller: passwordController,
          context: context,
          labelText: "Wachtwoord",
          keyboardType: TextInputType.visiblePassword,
          obscureText: true,
          icon: Icon(Icons.lock),
        ),
        SizedBox(
          height: 40,
        ),
        FlatButtonBOne(
          minWidth: double.infinity,
          text: "Aanmelden",
          onPressed: () {
            _login();
          },
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
