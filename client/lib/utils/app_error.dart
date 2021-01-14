import 'package:flutter/material.dart';

class AppError {
  AppError._();

  static void show(BuildContext context, String errorMessage) {
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text(errorMessage),
        duration: Duration(seconds: 5),
      ),
    );
  }
}
