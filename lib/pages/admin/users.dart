import 'package:flutter/material.dart';
import 'package:b_one_project_4_0/controller/userController.dart';
import 'package:b_one_project_4_0/models/user.dart';
import 'package:b_one_project_4_0/widgets/buttons/BottomAppBarBOne.dart';
import 'package:b_one_project_4_0/widgets/TopSearchBar.dart';
import 'package:b_one_project_4_0/pages/admin/userDetail.dart';
import 'package:mailto/mailto.dart';
import 'package:url_launcher/url_launcher.dart';

class UserOverviewPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _UserOverviewPage();
}

class _UserOverviewPage extends State {
  List<User> userList = List<User>();
  List<User> originalUserList = List<User>();

  int count = 0;

  final GlobalKey<ScaffoldState> _scaffoldKeyUsers =
      new GlobalKey<ScaffoldState>();

  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    searchController.addListener(_searchValueChanged);
    _getUsers();
  }

  void _getUsers() {
    UserController.loadUsers().then((result) {
      setState(() {
        originalUserList = result;
        // Users sorted alphabetical by last name
        originalUserList.sort((a, b) {
          return a.lastName.toLowerCase().compareTo(b.lastName.toLowerCase());
        });
        userList = originalUserList;
        count = userList.length;
        print("Count users overview: " + count.toString());
      });
    });
  }

  void _searchValueChanged() {
    print("Search text: ${searchController.text}");
    setState(() {
      this.userList = originalUserList
          .where((user) =>
              user.firstName
                  .toLowerCase()
                  .contains(searchController.text.toLowerCase()) ||
              user.lastName
                  .toLowerCase()
                  .contains(searchController.text.toLowerCase()) ||
              user.email
                  .toLowerCase()
                  .contains(searchController.text.toLowerCase()) ||
              user.address
                  .toLowerCase()
                  .contains(searchController.text.toLowerCase()) ||
              user.city
                  .toLowerCase()
                  .contains(searchController.text.toLowerCase()) ||
              user.postalCode
                  .toLowerCase()
                  .contains(searchController.text.toLowerCase()))
          .toList();
      // Users sorted alphabetical by last name
      this.userList.sort((a, b) {
        return a.lastName.toLowerCase().compareTo(b.lastName.toLowerCase());
      });
    });
    print("Filtered users list length: " + userList.length.toString());
  }

  // Open mail launcher on device
  void _launchMailto(
      String mailaddress, String firstName, String lastName) async {
    final mailtoLink = Mailto(
      to: [mailaddress],
      body: 'Geachte ' + firstName + " " + lastName + ',\n\n',
    );
    await launch('$mailtoLink');
  }

  // Dummy data are no real addresses!
  static Future<void> _openGoogleMaps(
      String address, String city, String postalcode) async {
    String googleUrl =
        'https://www.google.be/maps/place/$address+$postalcode+$city+Belgium/';
    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else {
      throw 'Could not open the map.';
    }
  }

// TODO: Go to user dertail by id;
  Future<void> _userDetail(id) async {
    //   Navigator.pushNamedAndRemoveUntil(
    //       context, '/admin/users/1', (route) => false);
    if (id == null) {
      Navigator.pushNamed(
          context, '/admin/users/new');
    } else {
      bool result = await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => UserDetailPage(id)),
      );
      if (result == true) {
        _getUsers();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKeyUsers,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Container(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Gebruikers',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    Padding(padding: EdgeInsets.all(10.0)),
                    TopSearchBar(
                      onPressedRight: () {
                        // TODO: go to user detail with empty values
                        _userDetail(null);
                        print("Pressed add user!");
                      },
                      textRight: "Gebruiker",
                      iconRight: Icons.person_add_alt_1,
                      controller: searchController,
                      color: Colors.grey.shade900,
                    ),
                    Padding(padding: EdgeInsets.all(10.0)),
                    Expanded(
                      child: this.userList.length != 0
                          ? _userListItems()
                          : Column(
                              children: <Widget>[
                                Text('Geen resultaten gevonden!'),
                                Expanded(
                                    child: Center(
                                        child: CircularProgressIndicator())),
                              ],
                            ),
                    ),
                  ]),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButtonBOne(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBarBOne(),
    );
  }

  ListView _userListItems() {
    return new ListView.builder(
      primary: false,
      shrinkWrap: true,
      physics: const AlwaysScrollableScrollPhysics(), // new
      scrollDirection: Axis.vertical,
      // shrinkWrap: true,
      itemCount: this.userList.length,
      itemBuilder: (BuildContext context, int position) {
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(
            leading: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // Show the first letter of the last name
                CircleAvatar(
                  backgroundColor: Theme.of(context).primaryColor,
                  child: Text(
                      this.userList[position].firstName.substring(0, 1) +
                          this.userList[position].lastName.substring(0, 1),
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
            title: Text(
              this.userList[position].firstName +
                  " " +
                  this.userList[position].lastName,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor),
            ),
            subtitle: Column(
              children: [
                Align(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(4.0),
                        ),
                        // Icon(Icons.mail_outline, size: 14, color: Colors.blue),
                        GestureDetector(
                            onTap: () {
                              print("Tapped on email!");
                              _launchMailto(
                                  this.userList[position].email.toString(),
                                  this.userList[position].firstName,
                                  this.userList[position].lastName);
                            },
                            child: Icon(Icons.mail_outline,
                                size: 14,
                                color: Theme.of(context).primaryColor)),
                        Padding(
                          padding: EdgeInsets.all(4.0),
                        ),
                        SizedBox(
                            width: 180.0,
                            child: GestureDetector(
                              onTap: () {
                                print("Tapped on email!");
                                _launchMailto(
                                    this.userList[position].email.toString(),
                                    this.userList[position].firstName,
                                    this.userList[position].lastName);
                              },
                              child: Text(
                                this.userList[position].email.toString(),
                                maxLines: 1,
                                overflow: TextOverflow.fade,
                                softWrap: false,
                              ),
                            )),
                      ],
                    )),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(4.0),
                        ),
                        GestureDetector(
                            onTap: () {
                              print("Tapped on location!");
                              _openGoogleMaps(
                                  this.userList[position].address,
                                  this.userList[position].city,
                                  this.userList[position].postalCode);
                            },
                            child: Icon(
                              Icons.place,
                              size: 14,
                              color: Theme.of(context).primaryColor,
                            )),
                        Padding(
                          padding: EdgeInsets.all(4.0),
                        ),
                        GestureDetector(
                            onTap: () {
                              print("Tapped on location!");
                              _openGoogleMaps(
                                  this.userList[position].address,
                                  this.userList[position].city,
                                  this.userList[position].postalCode);
                            },
                            child: Text(this.userList[position].address +
                                ",\n" +
                                this.userList[position].city +
                                " " +
                                this.userList[position].postalCode))
                      ],
                    )),
              ],
            ),
            trailing: IconButton(
              icon: Icon(Icons.navigate_next),
              color: Theme.of(context).accentColor,
              tooltip: 'Open actions menu',
              onPressed: () {
                print("Pressed trailing icon");
                _userDetail(this.userList[position].id);
              },
            ),
            isThreeLine: true,
            // subtitle: Text(this.userList[position].email),
            onTap: () {
              debugPrint("Tapped on " + this.userList[position].id.toString());
              print("Navigate to detail");
              _userDetail(this.userList[position].id);
            },
          ),
        );
      },
    );
  }
}
