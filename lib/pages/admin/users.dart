import 'package:flutter/material.dart';
import 'package:b_one_project_4_0/apis/user_api.dart';
import 'package:b_one_project_4_0/models/user.dart';
import 'package:b_one_project_4_0/widgets/buttons/BottomAppBarBOne.dart';
import 'package:b_one_project_4_0/widgets/TopSearchBar.dart';

class UserOverviewPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _UserOverviewPage();
}

class _UserOverviewPage extends State {
  List<User> userList = List<User>();
  // List userList = List();
  int count = 0;

  final GlobalKey<ScaffoldState> _scaffoldKeyUsers =
      new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _getUsers();
  }

  void _getUsers() {
    UserApi.fetchUsers().then((result) {
      print("Hello");
      setState(() {
        userList = result;
        count = result.length;
        print("Count: " + count.toString());
      });
    });
  }

// TODO: Go to user dertail by id;
  void _userDetail(int id) {
    Navigator.pushNamedAndRemoveUntil(
        context, '/admin/users/1', (route) => false);
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
                        print("Pressed add user");
                      },
                      textRight: "Gebruiker",
                      iconRight: Icons.person_add_alt_1,
                      color: Colors.grey.shade900,
                    ),
                    Padding(padding: EdgeInsets.all(10.0)),
                    Expanded(
                      child: this.count != 0
                          ? _userListItems()
                          : Center(child: CircularProgressIndicator()),
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
      itemCount: count,
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
                        Icon(Icons.mail_outline,
                            size: 14, color: Theme.of(context).primaryColor),
                        Padding(
                          padding: EdgeInsets.all(4.0),
                        ),
                        Text(this.userList[position].email),
                      ],
                    )),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(4.0),
                        ),
                        // Icon(Icons.place, size: 14, color: Colors.blue,),
                        Icon(
                          Icons.place,
                          size: 14,
                          color: Theme.of(context).primaryColor,
                        ),
                        Padding(
                          padding: EdgeInsets.all(4.0),
                        ),
                        Text(this.userList[position].address +
                            ",\n" +
                            this.userList[position].city +
                            " " +
                            this.userList[position].postalCode),
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
                // _showMyDialog(this.userList[position]);
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
