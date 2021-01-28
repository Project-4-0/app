import 'package:b_one_project_4_0/controller/authController.dart';
import 'package:b_one_project_4_0/pages/authLading/dashboard.dart';
import 'package:b_one_project_4_0/pages/info.dart';
import 'package:b_one_project_4_0/pages/login.dart';
import 'package:b_one_project_4_0/pages/monteur/QRScanner.dart';
import 'package:b_one_project_4_0/pages/monteur/connected.dart';
import 'package:b_one_project_4_0/pages/monteur/dashboard.dart';
import 'package:b_one_project_4_0/pages/profile.dart';
import 'package:b_one_project_4_0/pages/boer/dashboard.dart';
import 'package:b_one_project_4_0/pages/admin/dashboard.dart';
import 'package:b_one_project_4_0/pages/admin/users.dart';
import 'package:b_one_project_4_0/pages/admin/newUser.dart';
import 'package:b_one_project_4_0/pages/admin/userDetail.dart';
import 'package:b_one_project_4_0/pages/admin/boxen.dart';
import 'package:b_one_project_4_0/pages/admin/box.dart';
import 'package:b_one_project_4_0/pages/admin/newBox.dart';
import 'package:b_one_project_4_0/pages/test.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route generateRoute(RouteSettings settings) {
    // final args = settings.arguments;

    switch (settings.name) {
      //Default Dashboard
      case '/dashboard':
        return MaterialPageRoute(builder: (_) => AuthLadingDashboardPage());
      case '/admin/dashboard':
        return MaterialPageRoute(builder: (_) => AdminDashboardPage());
      case '/admin/users':
        return MaterialPageRoute(builder: (_) => UserOverviewPage());
      // Id parameter !!!
      case '/admin/users/1':
        return MaterialPageRoute(builder: (_) => UserDetailPage(1));
              case '/admin/users/new':
        return MaterialPageRoute(builder: (_) => NewUserPage());
      case '/admin/boxen':
        return MaterialPageRoute(builder: (_) => BoxenOverviewPage());
      case '/admin/boxen/1':
        return MaterialPageRoute(builder: (_) => BoxPage());
              case '/admin/boxen/new':
        return MaterialPageRoute(builder: (_) => NewBoxPage());

      case '/test':
        return MaterialPageRoute(builder: (_) => TestPage());

      case '/profile':
        return MaterialPageRoute(builder: (_) => ProfilePage());
      case '/boer/dashboard':
        return MaterialPageRoute(builder: (_) => DashboardPage());
      case '/info':
        return MaterialPageRoute(builder: (_) => InfoPage());
      case '/login':
        return MaterialPageRoute(builder: (_) => LoginPage());

      case '/monteur/dashboard':
        return MaterialPageRoute(builder: (_) => MonteurDashboardPage());
      case '/monteur/connected':
        return MaterialPageRoute(builder: (_) => MonteurConnectedPage());
      case '/monteur/QRSCanner':
        return MaterialPageRoute(builder: (_) => QRScannerPage());

      default:
        return _errorRoute();
    }
  }
}

Route<dynamic> _errorRoute() {
  return MaterialPageRoute(builder: (_) {
    return Scaffold(
      appBar: AppBar(
        title: Text('error'),
      ),
      body: Center(
        child: Text('Error'),
      ),
    );
  });
}
