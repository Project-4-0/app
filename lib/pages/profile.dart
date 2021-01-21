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
                    onPressed: () {},
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
