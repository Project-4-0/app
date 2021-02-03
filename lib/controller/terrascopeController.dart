/*
TerrascopeController
*/
import 'package:b_one_project_4_0/apis/terrascope_api.dart';
import 'package:b_one_project_4_0/models/terrascope.dart';

class TerrascopeController {
  // One box
  static Future<Terrascope> loadImage(int id) async {
    return TerrascopeAPI.fetchUrl(id).then((terrascope) {
      return terrascope;
    }).catchError((error) {
      // SnackBarController()
      //     .show(text: error.message, title: "Server", type: "ERROR");
      return null;
    });
  }
}
