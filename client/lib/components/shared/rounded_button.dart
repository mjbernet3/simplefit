import 'package:client/utils/constants.dart';
import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final String buttonText;
  final Function onPressed;
  final double height;
  final double fontSize;
  final Color color;
  final Color borderColor;
  final bool disabled;

  RoundedButton({
    @required this.buttonText,
    @required this.onPressed,
    this.height = 45.0,
    this.fontSize = 14.0,
    this.color = Constants.firstElevation,
    this.borderColor = Constants.firstElevation,
    this.disabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      height: height,
      child: RaisedButton(
        elevation: 0.0,
        child: Text(
          buttonText,
          style: TextStyle(
            color: Constants.highEmphasis,
            fontSize: fontSize,
          ),
        ),
        color: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
          side: BorderSide(color: borderColor),
        ),
        onPressed: !disabled ? onPressed : null,
      ),
    );
  }
}
