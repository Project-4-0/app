import 'package:b_one_project_4_0/pages/home.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route generateRoute(RouteSettings settings) {
    // final args = settings.arguments;

    switch (settings.name) {
      // case '/':
      //   return MaterialPageRoute(builder: (_) => LoginPage());
      case '/home':
        return MaterialPageRoute(builder: (_) => HomePage());
      // case '/registration':
      //   return MaterialPageRoute(builder: (_) => RegistrationPage());
      // case '/login':
      //   return MaterialPageRoute(builder: (_) => LoginPage());

      // case '/scanProduct':
      //   return MaterialPageRoute(builder: (_) => ScanProductPage());

      // case '/cart':
      //   return MaterialPageRoute(builder: (_) => CartPage());

      // case '/cartSucceed':
      //   return MaterialPageRoute(builder: (_) => CartSucceedPage());

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
