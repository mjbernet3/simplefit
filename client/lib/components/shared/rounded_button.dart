import 'package:client/utils/constants.dart';
import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final String buttonText;
  final Function onPressed;
  final double height;
  final double fontSize;
  final Color color;
  final bool disabled;

  RoundedButton({
    @required this.buttonText,
    this.onPressed,
    this.height = 45.0,
    this.fontSize = 14.0,
    this.color = Constants.firstElevation,
    this.disabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      height: height,
      child: ElevatedButton(
        child: Text(buttonText),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.pressed)) {
                return color.withOpacity(0.5);
              } else if (states.contains(MaterialState.disabled)) {
                return color.withOpacity(0.5);
              }

              return color;
            },
          ),
          foregroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.disabled)) {
                return Constants.lowEmphasis;
              }

              return Constants.highEmphasis;
            },
          ),
          overlayColor: MaterialStateProperty.all(color),
          shadowColor: MaterialStateProperty.all(Constants.backgroundColor),
          textStyle: MaterialStateProperty.all(TextStyle(fontSize: fontSize)),
        ),
        onPressed: !disabled ? onPressed : null,
      ),
    );
  }
}
