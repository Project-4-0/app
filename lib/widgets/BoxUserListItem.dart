import 'package:flutter/material.dart';
import 'package:b_one_project_4_0/models/box.dart';
// import 'package:b_one_project_4_0/models/location.dart';
import 'package:b_one_project_4_0/controller/locationController.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:b_one_project_4_0/controller/snackbarController.dart';

class BoxUserListItem extends StatefulWidget {
  final Box box;
  final GestureTapCallback onPressed;
  final GestureTapCallback onPressedDelete;
  final bool delete;
  BoxUserListItem({
    @required this.onPressed,
    this.onPressedDelete,
    @required this.delete,
    @required this.box,
    Key key,
  }) : super(key: key);
  @override
  State<StatefulWidget> createState() =>
      _BoxUserListItem(box, onPressed, onPressedDelete, delete);
}

class _BoxUserListItem extends State<BoxUserListItem> {
  Box box;
  GestureTapCallback onPressed;
  GestureTapCallback onPressedDelete;
  bool delete;
  _BoxUserListItem(this.box, this.onPressed, this.onPressedDelete, this.delete);

  String date;

  double boxLat;
  double boxLng;
  String displayAddress;

  @override
  void initState() {
    super.initState();
    // Get the address of the box
    _getAddressFromLatLng();
  }

// class BoxUserListItem extends StatelessWidget {
//   const BoxUserListItem({
//     @required this.onPressed,
//     this.onPressedDelete,
//     @required this.delete,
//     @required this.box, // TODO: Expect to get a full box object !!!
//     Key key,
//   }) : super(key: key);

  // final Box box;
  // final GestureTapCallback onPressed;
  // final GestureTapCallback onPressedDelete;
  // final bool delete;

// final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: this.onPressed,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        padding: EdgeInsets.all(5),
        // height: 90,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
          color: Colors.grey.shade100,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 5.0, // soften the shadow
              spreadRadius: 1.0, //extend the shadow
            )
          ],
        ),
        child: Row(
          children: [
            CircleAvatar(
                radius: 40.0,
                backgroundColor: Theme.of(context).primaryColor,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                  child: Center(
                      child: Text(this.box.name,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14.0),
                          textAlign: TextAlign.center)),
                )),
            SizedBox(
              width: 5,
            ),
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                // StartDate
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.date_range,
                      color: Theme.of(context).accentColor,
                      size: 16,
                    ),
                    Container(
                        width: delete ? 150.0 : 170.0,
                        padding: EdgeInsets.only(top: 5.0),
                        child: Text(
                          DateFormat('dd/MM/yyyy – kk:mm:ss')
                              .format(box.boxUser.startDate),
                          style: TextStyle(
                              color: Theme.of(context).accentColor,
                              fontSize: 14),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        )),
                  ],
                ),
                // Calculated address
                if (this.displayAddress != null)
                  GestureDetector(
                      onTap: () {
                        print("Tapped on location!");
                        _openGoogleMaps();
                      },
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.place,
                            color: Theme.of(context).accentColor,
                            size: 12,
                          ),
                          Container(
                              width: delete ? 150.0 : 170.0,
                              padding: EdgeInsets.only(top: 5.0),
                              child: Text(
                                this.displayAddress,
                                style: TextStyle(
                                    color: Theme.of(context).accentColor,
                                    fontSize: 12),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              )),
                        ],
                      )),
                // Comment
                if (box.comment != null &&
                    box.comment != "" &&
                    box.comment != " " &&
                    box.comment.isNotEmpty)
                  Row(
                    children: <Widget>[
                      Container(
                          width: delete ? 150.0 : 170.0,
                          padding: EdgeInsets.only(top: 5.0),
                          child: Text(
                            box.comment,
                            style: TextStyle(
                                color: Theme.of(context).accentColor,
                                fontSize: 10),
                            maxLines: 5,
                            overflow: TextOverflow.ellipsis,
                          )),
                    ],
                  ),
              ],
            )),
            if (delete)
              IconButton(
                icon: Icon(Icons.delete, color: Colors.red),
                onPressed: this.onPressedDelete,
              ),
          ],
        ),
      ),
    );
  }

  _getLatLngBox() async {
    print("Get the Lat & Lng of the box: " + this.box.name);
    await LocationController.getLocationOfBox(this.box.id).then((result) {
      if (result != null) {
        setState(() {
          this.boxLat = result.latitude;
          this.boxLng = result.longitude;
          print("LatLng: " +
              this.boxLat.toString() +
              " - " +
              this.boxLng.toString());
        });
      } else {
        print("Location for box: " + this.box.name + " is unknown!");
        this.boxLat = null;
        this.boxLng = null;
      }
    });
  }

  _getAddressFromLatLng() async {
    // Get the coordinates from the box
    await _getLatLngBox();

    print("Get the address of the box: " + this.box.name);
    try {
      if (this.boxLat != null && this.boxLng != null) {
        List<Placemark> placemarks =
            await placemarkFromCoordinates(this.boxLat, this.boxLng);
        Placemark place = placemarks[0];
        print('Get address');
        // print("Locality: " + place.locality);
        // print("PostalCode: " + place.postalCode);
        // print("Country: " + place.country);
        // print("ISO country code: " + place.isoCountryCode);

        if (place.locality != "" &&
            place.postalCode != null &&
            place.administrativeArea != null &&
            place.isoCountryCode != null) {
          setState(() {
            this.displayAddress = place.postalCode +
                " - " +
                place.locality +
                ",\n" +
                place.administrativeArea +
                " (" +
                place.isoCountryCode +
                ")";
            // this.displayAddress = place.name + " - " +  + ",\n" + place.locality;
          });
        } else {
          // If there is no address found for the box his coordinates
          setState(() {
            this.displayAddress = null;
          });
        }
      } else {
        // If there is no location found for the box display nothing
        setState(() {
          this.displayAddress = null;
        });
      }
    } catch (e) {
      print(e);
      setState(() {
        this.displayAddress = null;
      });
    }
  }

  Future<void> _openGoogleMaps() async {
    String googleUrl = 'https://www.google.com/maps/search/?api=1&query=' +
        this.boxLat.toString() +
        ',' +
        this.boxLng.toString();
    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else {
      SnackBarController().show(
          text: "Kan de map voor deze locatie niet opnenen",
          title: "Kan map niet openen",
          type: "ERROR");
      throw 'Could not open the map.';
    }
  }
}
