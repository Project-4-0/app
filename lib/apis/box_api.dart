import 'package:b_one_project_4_0/models/box.dart';

class BoxApi {
  // GET -> All boxen
  static Future<List<Box>> fetchBoxen() async {
    List dummyBoxList = [
      {
        "name": "Box 1",
        "mac_address": "mac_address54654654",
        "comment": "Hi i'm comment",
        "active": true,
        "id": 1
      },
      {
        "name": "Box 2",
        "mac_address": "mac_address54654654",
        "comment": "Hi i'm comment",
        "active": true,
        "id": 2
      },
      {
        "name": "Box 3",
        "mac_address": "mac_address54654654",
        "comment": null,
        "active": false,
        "id": 3
      },
    ];
    print("Inside user API - Get all users");
    return dummyBoxList.map((user) => new Box.fromJson(user)).toList();
  }
}
