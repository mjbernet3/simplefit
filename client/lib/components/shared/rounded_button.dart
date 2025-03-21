import 'package:client/utils/constants.dart';
import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;
  final double height;
  final Color color;
  final Color textColor;
  final double fontSize;
  final bool disabled;

  RoundedButton({
    required this.buttonText,
    required this.onPressed,
    this.height = 45.0,
    this.color = Constants.firstElevation,
    this.textColor = Constants.primaryColor,
    this.fontSize = 14.0,
    this.disabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: ElevatedButton(
        child: Text(buttonText),
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.resolveWith<Color>(
                (Set<WidgetState> states) {
              if (states.contains(WidgetState.pressed)) {
                return color.withValues(alpha: 0.5);
              } else if (states.contains(WidgetState.disabled)) {
                return color.withValues(alpha: 0.5);
              }
              return color;
            },
          ),
          foregroundColor: WidgetStateProperty.resolveWith<Color>(
                (Set<WidgetState> states) {
              if (states.contains(WidgetState.disabled)) {
                return Constants.lowEmphasis;
              }
              return textColor;
            },
          ),
          overlayColor: WidgetStateProperty.all(color),
          shadowColor: WidgetStateProperty.all(Constants.backgroundColor),
          textStyle: WidgetStateProperty.all(TextStyle(fontSize: fontSize)),
        ),
        onPressed: !disabled ? onPressed : null,
      ),
    );
  }
}
