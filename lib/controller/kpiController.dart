/*
KpiController
*/
import 'package:b_one_project_4_0/apis/box_api.dart';
import 'package:b_one_project_4_0/apis/kpi_api.dart';
import 'package:b_one_project_4_0/apis/terrascope_api.dart';
import 'package:b_one_project_4_0/controller/snackbarController.dart';
import 'package:b_one_project_4_0/models/box.dart';
import 'package:b_one_project_4_0/models/kpi.dart';
import 'package:b_one_project_4_0/models/terrascope.dart';

class KpiController {
  // One box
  static Future<Kpi> loadCount() async {
    return KpiApi.fetchCount().then((kpi) {
      return kpi;
    }).catchError((error) {
      SnackBarController()
          .show(text: error.message, title: "Server", type: "ERROR");
      return null;
    });
  }
}
