import 'package:client/utils/app_style.dart';
import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final Text buttonText;
  final Function onPressed;
  final double height;
  final Color color;
  final Color borderColor;
  final bool disabled;

  const RoundedButton({
    @required this.buttonText,
    @required this.onPressed,
    this.height = 45.0,
    this.color = AppStyle.backgroundColor,
    this.borderColor = Colors.white,
    this.disabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      height: height,
      child: RaisedButton(
        child: buttonText,
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
