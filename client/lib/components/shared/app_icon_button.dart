import 'package:client/utils/constants.dart';
import 'package:flutter/material.dart';

class AppIconButton extends StatelessWidget {
  final Icon icon;
  final VoidCallback onPressed;
  final OutlinedBorder shape;
  final EdgeInsets padding;
  final Color color;
  final double elevation;
  final bool disabled;

  AppIconButton({
    required this.icon,
    required this.onPressed,
    this.shape = const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(4.0)),
    ),
    this.padding = const EdgeInsets.all(0.0),
    this.color = Constants.firstElevation,
    this.elevation = 2.0,
    this.disabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
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
        foregroundColor: WidgetStateProperty.all(Constants.primaryColor),
        padding: WidgetStateProperty.all(padding),
        overlayColor: WidgetStateProperty.all(color),
        shadowColor: WidgetStateProperty.all(Constants.backgroundColor),
        minimumSize: WidgetStateProperty.all(Size(0.0, 0.0)),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        elevation: WidgetStateProperty.all(elevation),
        shape: WidgetStateProperty.all(shape),
      ),
      child: icon,
      onPressed: !disabled ? onPressed : null,
    );
  }
}
