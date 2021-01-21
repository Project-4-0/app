import 'package:b_one_project_4_0/widgets/TextFieldBOne.dart';
import 'package:b_one_project_4_0/widgets/buttons/BottomAppBarBOne.dart';
import 'package:b_one_project_4_0/widgets/buttons/FlatButtonBOne.dart';
import 'package:flutter/material.dart';

class UserDetailPage extends StatefulWidget {
  @override
  _UserDetailPageState createState() => _UserDetailPageState();
}

class _UserDetailPageState extends State<UserDetailPage> {
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
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFieldBOne(
                    context: context,
                    labelText: "Achternaam",
                    icon: Icon(Icons.person_outline),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFieldBOne(
                    context: context,
                    labelText: "Email",
                    icon: Icon(Icons.mail_outline),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFieldBOne(
                    context: context,
                    labelText: "Straat",
                    icon: Icon(Icons.location_on_outlined),
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
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  FlatButtonBOne(
                    minWidth: double.infinity,
                    text: "Opslaan",
                    onPressed: () {
                      print("Save user");
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
}
