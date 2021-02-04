/*
LocationController
*/
import 'package:b_one_project_4_0/apis/location_api.dart';
import 'package:b_one_project_4_0/controller/snackbarController.dart';
import 'package:b_one_project_4_0/models/location.dart';

class LocationController {

  // One box
  static Future<Location> getLocationOfBox(int boxID) async {
    return LocationApi.getLocationOfBox(boxID).then((location) {
      return location;
    }).catchError((error) {
      SnackBarController()
          .show(text: error.message, title: "Server", type: "ERROR");
      return null;
    });
  }
}


