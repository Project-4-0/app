/*
Measurementcontroller
*/
import 'package:b_one_project_4_0/apis/measurement_api.dart';
import 'package:b_one_project_4_0/controller/snackbarController.dart';
import 'package:b_one_project_4_0/models/measurement.dart';
import 'authController.dart';

class MeasurementController {
  static Future<List<Measurement>> loadMeasurementsGraphics(
      String sensorTypeName) async {
    var us = (await AuthController.getUser());

    return MeasurementApi.fetchMeasurementsGraphics(us.id, sensorTypeName)
        .then((measurement) {
      return measurement;
    }).catchError((error) {
      SnackBarController()
          .show(text: error.message, title: "Server", type: "ERROR");
      return null;
    });
  }
}
