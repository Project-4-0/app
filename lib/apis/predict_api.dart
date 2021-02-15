import 'package:b_one_project_4_0/models/filterMeasurement.dart';
import 'package:b_one_project_4_0/models/predict.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:intl/intl.dart';

class PredictApi {
  static String url = env['API_URL'];

  // GET: All boxes
  static Future<List<Predict>> fetchPredictByBoxID(
      FilterMeasurement filterMeasurement) async {
    var sendJson = {};
    //filters
    if (filterMeasurement.startDate != null) {
      sendJson["StartDate"] =
          DateFormat("yyyy-MM-ddTHH:mm:ss").format(filterMeasurement.startDate);
    }
    if (filterMeasurement.endDate != null) {
      sendJson["EndDate"] =
          DateFormat("yyyy-MM-ddTHH:mm:ss").format(filterMeasurement.endDate);
    }
    if (filterMeasurement.boxID != null) {
      sendJson["BoxID"] = filterMeasurement.boxID;
    }

    final http.Response response = await http.post(
      url + '/predict/box',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(sendJson),
    );

    // final response = await http.get(url + '/predict/box/' + filterMeasurement.boxID.toString());
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse
          .map((predict) => new Predict.fromJson(predict))
          .toList();
    } else {
      throw Exception(response.body);
    }
  }
}
