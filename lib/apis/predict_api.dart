import 'package:b_one_project_4_0/models/kpi.dart';
import 'package:b_one_project_4_0/models/predict.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PredictApi {
  static String url = env['API_URL'];

  // GET: All boxes
  static Future<List<Predict>> fetchPredictByBoxID(int id) async {
    final response = await http.get(url + '/predict/box/' + id.toString());
    if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((predict) => new Predict.fromJson(predict)).toList();

    } else {
      throw Exception(response.body);
    }
  }

  
}
