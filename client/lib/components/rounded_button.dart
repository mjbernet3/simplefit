import 'package:client/app_style.dart';
import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final Text buttonText;
  final Color fillColor;
  final Color borderColor;
  final Function onPressed;

  const RoundedButton({
    @required this.onPressed,
    this.fillColor = AppStyle.backgroundColor,
    this.borderColor = Colors.white,
    this.buttonText = const Text(''),
  });

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: onPressed,
      color: fillColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
        side: BorderSide(color: borderColor),
      ),
      child: buttonText,
    );
  }
}
