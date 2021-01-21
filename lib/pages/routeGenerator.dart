import 'package:b_one_project_4_0/pages/info.dart';
import 'package:b_one_project_4_0/pages/login.dart';
import 'package:b_one_project_4_0/pages/monteur/QRScanner.dart';
import 'package:b_one_project_4_0/pages/monteur/connected.dart';
import 'package:b_one_project_4_0/pages/monteur/dashboard.dart';
import 'package:b_one_project_4_0/pages/profile.dart';
import 'package:b_one_project_4_0/pages/boer/dashboard.dart';
import 'package:b_one_project_4_0/pages/admin/dashboard.dart';
import 'package:b_one_project_4_0/pages/test.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route generateRoute(RouteSettings settings) {
    // final args = settings.arguments;

    switch (settings.name) {
      // case '/':
      //   return MaterialPageRoute(builder: (_) => LoginPage());
      case '/admin/dashboard':
        return MaterialPageRoute(builder: (_) => AdminDashboardPage());
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

      case '/monteur':
        return MaterialPageRoute(builder: (_) => MonteurDashboardPage());
      case '/monteur/connected':
        return MaterialPageRoute(builder: (_) => MonteurConnectedPage());

      case '/monteur/QRSCanner':
        return MaterialPageRoute(builder: (_) => QRScannerPage());
      // case '/registration':
      // case '/registration':
      //   return MaterialPageRoute(builder: (_) => RegistrationPage());
      // case '/login':
      //   return MaterialPageRoute(builder: (_) => LoginPage());
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
