// import 'package:gshop/models/MeasurementRegistration.dart';
// import 'package:gshop/models/auth.dart';
import 'package:b_one_project_4_0/models/filterMeasurement.dart';
import 'package:b_one_project_4_0/models/measurement.dart';
import 'package:b_one_project_4_0/models/measurementGraphics.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:intl/intl.dart';

class MeasurementApi {
  static String url = env['API_URL'];

  static Future<List<Measurement>> fetchMeasurements() async {
    final response = await http.get(url + '/measurements');

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse
          .map((user) => new Measurement.fromJson(user))
          .toList();
    } else {
      throw Exception(response.body);
    }
  }

  static Future<Measurement> fetchMeasurement(int id) async {
    final response = await http.get(url + '/measurements/' + id.toString());
    if (response.statusCode == 200) {
      return Measurement.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(response.body);
    }
  }

  static Future<Measurement> createMeasurement(Measurement measurement) async {
    final http.Response response = await http.post(
      url + '/signup',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(measurement),
    );
    if (response.statusCode == 201) {
      return Measurement.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(response.body);
    }
  }

  static Future<Measurement> updateMeasurement(Measurement measurement) async {
    final http.Response response = await http.put(
      url + '/measurements',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(measurement),
    );
    if (response.statusCode == 200) {
      return Measurement.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(response.body);
    }
  }

  static Future deleteMeasurement(int id) async {
    final http.Response response =
        await http.delete(url + '/measurements/' + id.toString());
    if (response.statusCode == 200) {
      return;
    } else {
      throw Exception(response.body);
    }
  }

  // static Future<List<Measurement>> fetchMeasurementsGraphics() async {
  //   final response = await http.post(url + '/measurements/graphics');

  //   if (response.statusCode == 200) {
  //     List jsonResponse = json.decode(response.body);
  //     return jsonResponse
  //         .map((user) => new Measurement.fromJson(user))
  //         .toList();
  //   } else {
  //     throw Exception(response.body);
  //   }
  // }

  static Future<MeasurementGraphics> fetchMeasurementsGraphics(int userID,
      String sensorTypeName, FilterMeasurement filterMeasurement) async {
    var sendJson = {"UserID": userID, "SensorTypeName": sensorTypeName};

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

    // print(sendJson);

    final http.Response response = await http.post(
      url + '/measurements/graphics',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(sendJson),
    );
    if (response.statusCode == 200) {
      return MeasurementGraphics.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(response.body);
    }
  }
}
