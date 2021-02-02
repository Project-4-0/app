import 'package:b_one_project_4_0/widgets/CardBOne.dart';
import 'package:b_one_project_4_0/widgets/SafeAreaBOne/safeAreaBOne.dart';
import 'package:b_one_project_4_0/widgets/buttons/BottomAppBarBOne.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class InfoPage extends StatefulWidget {
  @override
  _InfoPageState createState() => _InfoPageState();
}

Future<void> _openGoogleMaps() async {
  String mapsUrl =
      'https://www.google.be/maps/place/Vlaamse+Instelling+voor+Technologisch+Onderzoek+(VITO)/@51.2188255,5.0820453,16z/data=!4m8!1m2!2m1!1sVITO+mol!3m4!1s0x47c1355b64ad27ef:0xd30605e97dd9b2f8!8m2!3d51.2190049!4d5.0935338';
  if (await canLaunch(mapsUrl)) {
    await launch(mapsUrl);
  } else {
    throw 'Kan de map niet openen!';
  }
}

Future<void> _openUrl() async {
  String vitoURL = 'https://www.vito.be/nl';
  if (await canLaunch(vitoURL)) {
    await launch(vitoURL);
  } else {
    throw 'Kan de website van VITO niet laden!';
  }
}

class _InfoPageState extends State<InfoPage> {
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
                    'Info',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(10.0)),
                  Image(
                    image: AssetImage("assets/vito_remote_sensing_trim.png"),
                    width: 200.0,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(children: [
                    Expanded(
                        child: GestureDetector(
                            child: CardBOne(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.language,
                                    size: 50,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  Text(
                                    "www.vito.be",
                                  ),
                                ],
                              ),
                            ),
                            onTap: () {
                              print("Open website");
                              _openUrl();
                            }))
                  ]),
                  IntrinsicHeight(
                      child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                            child: CardBOne(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.location_on,
                                    size: 50,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  Text(
                                    "Boeretang 200",
                                    style: TextStyle(fontSize: 15),
                                  ),
                                  Text(
                                    "2400 Mol",
                                    style: TextStyle(fontSize: 15),
                                  ),
                                ],
                              ),
                            ),
                            onTap: () {
                              print("Open location in maps");
                              _openGoogleMaps();
                            }),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                          child: GestureDetector(
                              child: CardBOne(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.call,
                                      size: 50,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                    Text(
                                      "014 33 55 11",
                                    ),
                                  ],
                                ),
                              ),
                              onTap: () {
                                print("Open tel app");
                                launch("tel://014 33 55 11");
                              }))
                    ],
                  )),
                  Text(
                      "VITO is een Vlaamse onafhankelijke onderzoeksorganisatie op het gebied van cleantech en duurzame ontwikkeling.",
                      textAlign: TextAlign.center),
                  Text(
                      "\nOns doel?\nDe transitie versnellen naar een duurzame wereld.",
                      textAlign: TextAlign.center),
                  SizedBox(
                    height: 40,
                  ),
                  Text("In samenwerking met",
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                      )),
                  SizedBox(
                    height: 30,
                  ),
                  Image(
                    image: AssetImage("assets/Bone.png"),
                    height: 120,
                  ),
                  Text(
                      "Een groep van 6 enthousiaste studenten die trachten een top project af te leveren. Een project waar zowel VITO, de opleiding alsook wij meer als tevreden zijn met het eindresultaat.",
                      textAlign: TextAlign.center),
                  IntrinsicHeight(
                      child: Row(
                    children: [
                      Expanded(
                        child: CardBOne(
                          child: Column(
                            children: [
                              Image(
                                image: AssetImage("assets/YouriVanLaer.png"),
                                height: 120,
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              Text("Youri Van Laer",
                                  textAlign: TextAlign.center),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: CardBOne(
                          child: Column(
                            children: [
                              Image(
                                image: AssetImage(
                                    "assets/ArnoVangoetsenhoven.png"),
                                height: 120,
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              Text("Arno Vangoetsenhoven",
                                  textAlign: TextAlign.center),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )),
                  Row(
                    children: [
                      Expanded(
                        child: CardBOne(
                          child: Column(
                            children: [
                              Image(
                                image: AssetImage("assets/RubenLuyten.png"),
                                height: 120,
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              Text("Ruben Luyten", textAlign: TextAlign.center),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: CardBOne(
                          child: Column(
                            children: [
                              Image(
                                image: AssetImage("assets/RobertBlaga.png"),
                                height: 120,
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              Text("Robert Blaga", textAlign: TextAlign.center),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: CardBOne(
                          child: Column(
                            children: [
                              Image(
                                image: AssetImage("assets/JariNeyens.png"),
                                height: 120,
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              Text("Jari Neyens", textAlign: TextAlign.center),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: CardBOne(
                          child: Column(
                            children: [
                              Image(
                                image: AssetImage("assets/SenneVanPelt.png"),
                                height: 120,
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              Text("Senne Van Pelt",
                                  textAlign: TextAlign.center),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButtonBOne(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBarBOne(active: 3),
    );
  }
}
