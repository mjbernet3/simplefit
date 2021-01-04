import 'package:client/utils/app_style.dart';
import 'package:flutter/material.dart';

class AppError {
  AppError._();

  static void show(BuildContext context, String errorMessage) {
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text(
          errorMessage,
          style: TextStyle(
            color: AppStyle.highEmphasisText,
          ),
        ),
        backgroundColor: AppStyle.dp8,
        duration: Duration(seconds: 5),
      ),
    );
  }
}
