import 'package:b_one_project_4_0/models/user.dart';

class UserApi {
  // GET -> All users
  static Future<List<User>> fetchUsers() async {
    List dummyUserList = [
      {
        "first_name": "Admin",
        "last_name": "Admin",
        "password": "admin",
        "email": "admin@example.com",
        "address": "Teststraat 44",
        "postal_code": "2260",
        "city": "City",
        "id": 1
      },
      {
        "first_name": "Arno",
        "last_name": "Vangoetsenhoven",
        "password": "test",
        "email": "arno.vgh2@hotmail.com",
        "address": "Harmoniestraat 44",
        "postal_code": "2230",
        "city": "Ramsel",
        "id": 2
      },
      {
        "first_name": "Arno",
        "last_name": "Vangoetsenhoven",
        "password": "test",
        "email": "arno.vgh2@hotmail.com",
        "address": "Harmoniestraat 44",
        "postal_code": "2230",
        "city": "Ramsel",
        "id": 2
      },
      {
        "first_name": "Arno",
        "last_name": "Vangoetsenhoven",
        "password": "test",
        "email": "arno.vgh2@hotmail.com",
        "address": "Harmoniestraat 44",
        "postal_code": "2230",
        "city": "Ramsel",
        "id": 2
      },
      {
        "first_name": "Arno",
        "last_name": "Vangoetsenhoven",
        "password": "test",
        "email": "arno.vgh2@hotmail.com",
        "address": "Harmoniestraat 44",
        "postal_code": "2230",
        "city": "Ramsel",
        "id": 2
      },
      {
        "first_name": "Arno",
        "last_name": "Vangoetsenhoven",
        "password": "test",
        "email": "arno.vgh2@hotmail.com",
        "address": "Harmoniestraat 44",
        "postal_code": "2230",
        "city": "Ramsel",
        "id": 2
      },
      {
        "first_name": "Arno",
        "last_name": "Vangoetsenhoven",
        "password": "test",
        "email": "arno.vgh2@hotmail.com",
        "address": "Harmoniestraat 44",
        "postal_code": "2230",
        "city": "Ramsel",
        "id": 2
      },
      {
        "first_name": "Arno",
        "last_name": "Vangoetsenhoven",
        "password": "test",
        "email": "arno.vgh2@hotmail.com",
        "address": "Harmoniestraat 44",
        "postal_code": "2230",
        "city": "Ramsel",
        "id": 2
      },
      {
        "first_name": "Arno",
        "last_name": "Vangoetsenhoven",
        "password": "test",
        "email": "arno.vgh2@hotmail.com",
        "address": "Harmoniestraat 44",
        "postal_code": "2230",
        "city": "Ramsel",
        "id": 2
      },
      {
        "first_name": "Arno",
        "last_name": "Vangoetsenhoven",
        "password": "test",
        "email": "arno.vgh2@hotmail.com",
        "address": "Harmoniestraat 44",
        "postal_code": "2230",
        "city": "Ramsel",
        "id": 2
      },
      {
        "first_name": "Arno",
        "last_name": "Vangoetsenhoven",
        "password": "test",
        "email": "arno.vgh2@hotmail.com",
        "address": "Harmoniestraat 44",
        "postal_code": "2230",
        "city": "Ramsel",
        "id": 2
      },
      {
        "first_name": "Arno",
        "last_name": "Vangoetsenhoven",
        "password": "test",
        "email": "arno.vgh2@hotmail.com",
        "address": "Harmoniestraat 44",
        "postal_code": "2230",
        "city": "Ramsel",
        "id": 2
      },
      {
        "first_name": "Arno",
        "last_name": "Vangoetsenhoven",
        "password": "test",
        "email": "arno.vgh2@hotmail.com",
        "address": "Harmoniestraat 44",
        "postal_code": "2230",
        "city": "Ramsel",
        "id": 2
      },
      {
        "first_name": "Arno",
        "last_name": "Vangoetsenhoven",
        "password": "test",
        "email": "arno.vgh2@hotmail.com",
        "address": "Harmoniestraat 44",
        "postal_code": "2230",
        "city": "Ramsel",
        "id": 2
      },
      {
        "first_name": "Arno",
        "last_name": "Vangoetsenhoven",
        "password": "test",
        "email": "arno.vgh2@hotmail.com",
        "address": "Harmoniestraat 44",
        "postal_code": "2230",
        "city": "Ramsel",
        "id": 2
      },
      {
        "first_name": "Arno",
        "last_name": "Vangoetsenhoven",
        "password": "test",
        "email": "arno.vgh2@hotmail.com",
        "address": "Harmoniestraat 44",
        "postal_code": "2230",
        "city": "Ramsel",
        "id": 2
      },
      {
        "first_name": "Arno",
        "last_name": "Vangoetsenhoven",
        "password": "test",
        "email": "arno.vgh2@hotmail.com",
        "address": "Harmoniestraat 44",
        "postal_code": "2230",
        "city": "Ramsel",
        "id": 2
      }
    ];
    print("Inside user API - Get all users");
    return dummyUserList.map((user) => new User.fromJson(user)).toList();
  }
}
