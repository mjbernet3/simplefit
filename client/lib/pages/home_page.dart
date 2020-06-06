import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  static const String pageRoute = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Home',
          style: TextStyle(
            fontSize: 40.0,
          ),
        ),
      ),
    );
  }
}
