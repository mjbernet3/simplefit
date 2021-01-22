import 'package:client/utils/constants.dart';
import 'package:flutter/material.dart';

class InfoTag extends StatelessWidget {
  final String infoText;

  InfoTag({@required this.infoText});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Constants.primaryColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 2.0,
          horizontal: 4.0,
        ),
        child: Text(
          infoText,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Constants.backgroundColor,
          ),
        ),
      ),
    );
  }
}
