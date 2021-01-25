import 'package:b_one_project_4_0/controller/authController.dart';
import 'package:flutter/material.dart';

class AuthLadingDashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AuthController.getUserTypeName().then((name) => {
          if (name == "Admin")
            {Navigator.pushReplacementNamed(context, '/admin/dashboard')}
          else if (name == "Monteur")
            {Navigator.pushReplacementNamed(context, '/monteur/dashboard')}
          else if (name == "Boer")
            {Navigator.pushReplacementNamed(context, '/boer/dashboard')}
        });

    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
