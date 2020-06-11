import 'package:client/app_style.dart';
import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final Text buttonText;
  final Function onPressed;

  const RoundedButton({
    @required this.buttonText,
    @required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      height: 45.0,
      child: RaisedButton(
        child: buttonText,
        color: AppStyle.backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
          side: BorderSide(color: Colors.white),
        ),
        onPressed: onPressed,
      ),
    );
  }
}
