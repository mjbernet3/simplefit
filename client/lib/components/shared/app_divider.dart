import 'package:client/app_style.dart';
import 'package:flutter/material.dart';

class AppDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Divider(
      thickness: 1.5,
      color: AppStyle.dp24,
    );
  }
}