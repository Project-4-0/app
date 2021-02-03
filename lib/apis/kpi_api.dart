import 'package:b_one_project_4_0/models/kpi.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class KpiApi {
  static String url = env['API_URL'];

  // GET: All boxes
  static Future<Kpi> fetchCount() async {
    final response = await http.get(url + '/kpi/adminDashboard');
    if (response.statusCode == 200) {
      return Kpi.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(response.body);
    }
  }

  
}
