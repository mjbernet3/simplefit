import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  static const String pageRoute = '/welcome';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Welcome',
          style: TextStyle(
            fontSize: 40.0,
          ),
        ),
      ),
    );
  }
}
