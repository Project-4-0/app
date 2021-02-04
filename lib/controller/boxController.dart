/*
BoxController
*/
import 'package:b_one_project_4_0/apis/box_api.dart';
import 'package:b_one_project_4_0/controller/snackbarController.dart';
import 'package:b_one_project_4_0/models/box.dart';

class BoxController {
  // All boxes
  static Future<List<Box>> loadBoxes() async {
    return BoxApi.fetchBoxes().then((boxList) {
      return boxList;
    }).catchError((error) {
      SnackBarController()
          .show(text: error.message, title: "Server", type: "ERROR");
      return null;
    });
  }
  // 51.14608209946503, 5.002915324972558

  // One box
  static Future<Box> loadBox(int id) async {
    return BoxApi.fetchBox(id).then((box) {
      return box;
    }).catchError((error) {
      SnackBarController()
          .show(text: error.message, title: "Server", type: "ERROR");
      return null;
    });
  }

  // One box by macAddress
  static Future<Box> loadBoxWithMacAddress(String macAddress) async {
    return BoxApi.fetchBoxByMacAddress(macAddress).then((box) {
      return box;
    }).catchError((error) {
      SnackBarController()
          .show(text: error.message, title: "Server", type: "ERROR");
      return null;
    });
  }

  // One box with all information
  static Future<Box> loadBoxAll(int id) async {
    return BoxApi.fetchBoxAll(id).then((box) {
      return box;
    }).catchError((error) {
      SnackBarController().show(
          text: "Kan box info niet ophalen!", title: "Server", type: "ERROR");
      return null;
    });
  }

  // Create new box
  static Future<Box> createBox(Box box) async {
    return BoxApi.createBox(box).then((box) {
      return box;
    }).catchError((error) {
      SnackBarController()
          .show(text: error.message, title: "Server", type: "ERROR");
      return false;
    });
  }

  // Update box
  static Future<Box> updateBox(Box box) async {
    return BoxApi.updateBox(box).then((box) {
      return box;
    }).catchError((error) {
      SnackBarController()
          .show(text: error.message, title: "Server", type: "ERROR");
      return false;
    });
  }

  // Delete box
  static Future<bool> deleteBox(int id) async {
    return BoxApi.deleteBox(id).then((deleted) {
      if (deleted) {
        return true;
      } else {
        return false;
      }
    }).catchError((error) {
      SnackBarController()
          .show(text: error.message, title: "Server", type: "ERROR");
      return false;
    });
  }


}
