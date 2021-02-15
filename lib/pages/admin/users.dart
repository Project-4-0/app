import 'package:flutter/material.dart';
import 'package:b_one_project_4_0/controller/userController.dart';
import 'package:b_one_project_4_0/models/user.dart';
import 'package:b_one_project_4_0/widgets/buttons/BottomAppBarBOne.dart';
import 'package:b_one_project_4_0/widgets/TopSearchBar.dart';
import 'package:b_one_project_4_0/widgets/UserListItem.dart';
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
          .where((user) => user.address == null
              ? (user.firstName
                      .toLowerCase()
                      .contains(searchController.text.toLowerCase()) ||
                  user.lastName
                      .toLowerCase()
                      .contains(searchController.text.toLowerCase()) ||
                  user.email
                      .toLowerCase()
                      .contains(searchController.text.toLowerCase()))
              : (user.firstName
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
                      .contains(searchController.text.toLowerCase())))
          .toList();
      // Users sorted alphabetical by last name
      this.userList.sort((a, b) {
        return a.lastName.toLowerCase().compareTo(b.lastName.toLowerCase());
      });
    });
    print("Filtered users list length: " + userList.length.toString());
  }

  // Open mail launcher on device
  // void _launchMailto(
  //     String mailaddress, String firstName, String lastName) async {
  //   final mailtoLink = Mailto(
  //     to: [mailaddress],
  //     body: 'Geachte ' + firstName + " " + lastName + ',\n\n',
  //   );
  //   await launch('$mailtoLink');
  // }

  // static Future<void> _openGoogleMaps(
  //     String address, String city, String postalcode) async {
  //   String googleUrl =
  //       'https://www.google.be/maps/place/$address+$postalcode+$city+Belgium/';
  //   if (await canLaunch(googleUrl)) {
  //     await launch(googleUrl);
  //   } else {
  //     throw 'Could not open the map.';
  //   }
  // }

  Future<void> _userDetail(id) async {
    if (id == null) {
      Navigator.pushNamed(context, '/admin/users/new');
    } else {
      bool result = await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => UserDetailPage(id)),
      );
      if (result == true) {
        // Refresh userList when coming back from detail page
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
      bottomNavigationBar: BottomAppBarBOne(
        active: 1,
      ),
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
        return UserListItem(
          user: this.userList[position],
          showTrailingIcon: true,
          onPressed: () {
            print("Pressed trailing icon");
            _userDetail(this.userList[position].id);
          },
        );
      },
    );
  }
}
