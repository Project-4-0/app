import 'package:flutter/material.dart';
import 'package:b_one_project_4_0/models/user.dart';
import 'package:mailto/mailto.dart';
import 'package:url_launcher/url_launcher.dart';

class UserListItem extends StatelessWidget {
  const UserListItem({
    @required this.user,
    @required this.onPressed,
    @required this.showTrailingIcon,
    Key key,
  }) : super(key: key);

  final User user;
  final GestureTapCallback onPressed;
  final bool showTrailingIcon;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
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
                  this.user.firstName.substring(0, 1) +
                      this.user.lastName.substring(0, 1),
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
        title: Text(
          this.user.firstName + " " + this.user.lastName,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor),
        ),
        subtitle: Column(
          children: [
            if (this.user.email != null)
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
                            _launchMailto(this.user.email.toString(),
                                this.user.firstName, this.user.lastName);
                          },
                          child: Icon(Icons.mail_outline,
                              size: 14, color: Theme.of(context).primaryColor)),
                      Padding(
                        padding: EdgeInsets.all(4.0),
                      ),
                      SizedBox(
                          width: showTrailingIcon ? 170.0 : 190.0,
                          child: GestureDetector(
                            onTap: () {
                              print("Tapped on email!");
                              _launchMailto(this.user.email.toString(),
                                  this.user.firstName, this.user.lastName);
                            },
                            child: Text(
                              this.user.email.toString(),
                              maxLines: 1,
                              overflow: TextOverflow.fade,
                              softWrap: false,
                            ),
                          )),
                    ],
                  )),
            if (this.user.address != null &&
                this.user.city != null &&
                this.user.postalCode != null)
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
                            _openGoogleMaps(this.user.address, this.user.city,
                                this.user.postalCode);
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
                            _openGoogleMaps(this.user.address, this.user.city,
                                this.user.postalCode);
                          },
                          child: SizedBox(
                              width: showTrailingIcon ? 170.0 : 190.0,
                              child: Text(
                                this.user.address +
                                    ",\n" +
                                    this.user.city +
                                    " " +
                                    this.user.postalCode,
                                maxLines: 2,
                                overflow: TextOverflow.fade,
                                softWrap: false,
                              )))
                    ],
                  )),
          ],
        ),

        trailing: showTrailingIcon
            ? IconButton(
                icon: Icon(Icons.navigate_next),
                color: Theme.of(context).accentColor,
                onPressed: this.onPressed,
              )
            : null,
        isThreeLine: true,
        // subtitle: Text(this.user.email),
        onTap: this.onPressed,
      ),
    );
  }

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

  // Open mail launcher on device
  void _launchMailto(
      String mailaddress, String firstName, String lastName) async {
    final mailtoLink = Mailto(
      to: [mailaddress],
      body: 'Geachte ' + firstName + " " + lastName + ',\n\n',
    );
    await launch('$mailtoLink');
  }
}
