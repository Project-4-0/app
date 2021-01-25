import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:singleton/singleton.dart';

/*
SnackbarNotification 
You can call where every you wont. 
*/
class SnackBarController {
  //make a singeton
  factory SnackBarController() =>
      Singleton.lazy(() => SnackBarController._()).instance;

  String type = "";
  String text = "";
  String title = "";
  Color color = Colors.white;

  SnackBarController._();

  show({String type, String text, String title}) {
    this.type = type;
    this.text = text;
    this.title = title;
    _cases();

    Get.snackbar(
      this.title, // title
      this.text, // message
      // icon: Icon(Icons.alarm),
      shouldIconPulse: false,
      barBlur: 50,
      colorText: Colors.white,
      isDismissible: true,
      duration: Duration(seconds: 5),
      snackPosition: SnackPosition.TOP,
      margin: EdgeInsets.all(20),
      backgroundColor: this.color,
    );
  }

  _cases() {
    switch (this.type) {
      case "INFO":
        {
          this.color = Colors.blue;
        }
        break;
      case "GOOD":
        {
          this.color = Colors.green;
        }
        break;
      case "ERROR":
        {
          this.color = Colors.red;
        }
        break;
      default:
        {
          this.color = Colors.grey;
        }
        break;
    }
  }
}
