/*
PredictController
*/
import 'package:b_one_project_4_0/apis/kpi_api.dart';
import 'package:b_one_project_4_0/apis/predict_api.dart';
import 'package:b_one_project_4_0/controller/snackbarController.dart';
import 'package:b_one_project_4_0/models/filterMeasurement.dart';
import 'package:b_one_project_4_0/models/predict.dart';

class PredictController {
  // One box
  static Future<List<Predict>> fetchPredictByBoxID(FilterMeasurement filterMeasurement) async {
    return PredictApi.fetchPredictByBoxID(filterMeasurement).then((predict) {
      return predict;
    }).catchError((error) {
      SnackBarController()
          .show(text: error.message, title: "Server", type: "ERROR");
      return null;
    });
  }
}
