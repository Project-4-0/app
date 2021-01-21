import 'package:b_one_project_4_0/widgets/TextFieldBOne.dart';
import 'package:b_one_project_4_0/widgets/buttons/BottomAppBarBOne.dart';
import 'package:b_one_project_4_0/widgets/buttons/FlatButtonBOne.dart';
import 'package:flutter/material.dart';
import 'package:multi_select_item/multi_select_item.dart';

class UserDetailPage extends StatefulWidget {
  @override
  _UserDetailPageState createState() => _UserDetailPageState();
}

class _UserDetailPageState extends State<UserDetailPage> {
  List mainList =
      new List(); // TODO: Replace by list of boxes with a distinction between available, unavailble and owned boxes!
  MultiSelectController controller = new MultiSelectController();

  @override
  void initState() {
    super.initState();

    mainList.add({"key": "1"});
    mainList.add({"key": "2"});
    mainList.add({"key": "3"});
    mainList.add({"key": "4"});

    controller.disableEditingWhenNoneSelected = true;
    controller.set(mainList.length);
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
