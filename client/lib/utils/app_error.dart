import 'package:client/utils/constants.dart';
import 'package:flutter/material.dart';

class AppError {
  AppError._();

  static void show(BuildContext context, String errorMessage) {
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text(errorMessage),
        backgroundColor: Constants.secondElevation,
        duration: Duration(seconds: 5),
      ),
    );
  }
}
