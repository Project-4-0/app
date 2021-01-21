import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:b_one_project_4_0/style/custom_color_scheme.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv;
import 'package:b_one_project_4_0/pages/routeGenerator.dart';

Future main() async {
  // envioment variable
  await DotEnv.load(fileName: ".env");
  //...runapp
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'B One',
      theme: bOneTheme,
      initialRoute: '/info',
      // Work with Generate routes
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
