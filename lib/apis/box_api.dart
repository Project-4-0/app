import 'package:b_one_project_4_0/models/box.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BoxApi {
  static String url = env['API_URL'];

  // GET: All boxes
  static Future<List<Box>> fetchBoxes() async {
    final response = await http.get(url + '/boxes');
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((box) => new Box.fromJsonW(box)).toList();
    } else {
      throw Exception(response.body);
    }
  }

  // GET: One box
  static Future<Box> fetchBox(int id) async {
    final response = await http.get(url + '/boxes/' + id.toString());
    if (response.statusCode == 200) {
      return Box.fromJsonW(jsonDecode(response.body));
    } else {
      throw Exception(response.body);
    }
  }

    // GET: One box by macAddress
  static Future<Box> fetchBoxByMacAddress(String macAddress) async {
          final http.Response response = await http.post(
      url + '/boxes/macAddress',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
      'MacAddress': macAddress,
    }),
    );
    if (response.statusCode == 200) {
      return Box.fromJsonW(jsonDecode(response.body));
    } else {
      throw Exception(response.body);
    }
  }


  // GET: One box with ALL info
  static Future<Box> fetchBoxAll(int id) async {
    final response = await http.get(url + '/boxes/' + id.toString() + '/all');
    if (response.statusCode == 200) {
      return Box.fromJsonAll(jsonDecode(response.body));
    } else {
      throw Exception(response.body);
    }
  }

  // POST: create a new box
  static Future<Box> createBox(Box box) async {
    final http.Response response = await http.post(
      url + '/boxes',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(box),
    );
    if (response.statusCode == 201) {
      return Box.fromJsonW(jsonDecode(response.body));
    } else {
      throw Exception(response.body);
    }
  }

  // PUT: update a box
  static Future<Box> updateBox(Box box) async {
    final http.Response response = await http.put(
      url + '/boxes',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(box),
    );
    if (response.statusCode == 200) {
      return Box.fromJsonW(jsonDecode(response.body));
    } else {
      throw Exception(response.body);
    }
  }

  static Future deleteBox(int id) async {
    final http.Response response =
        await http.delete(url + '/boxes/' + id.toString());
    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception(response.body);
    }
  }

// GET -> All boxen
  // static Future<List<Box>> fetchBoxen() async {
  //   List dummyBoxList = [
  //     {
  //       "name": "Box 1",
  //       "mac_address": "mac_address54654654",
  //       "comment": "Hi i'm comment",
  //       "active": true,
  //       "id": 1
  //     },
  //     {
  //       "name": "Box 2",
  //       "mac_address": "mac_address54654654",
  //       "comment": "Hi i'm comment",
  //       "active": true,
  //       "id": 2
  //     },
  //     {
  //       "name": "Box 3",
  //       "mac_address": "mac_address54654654",
  //       "comment": null,
  //       "active": false,
  //       "id": 3
  //     },
  //   ];
  //   print("Inside user API - Get all users");
  //   return dummyBoxList.map((user) => new Box.fromJson(user)).toList();
  // }

}
