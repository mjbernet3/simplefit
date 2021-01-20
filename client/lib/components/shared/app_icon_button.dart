import 'package:client/utils/constants.dart';
import 'package:flutter/material.dart';

class AppIconButton extends StatelessWidget {
  final Icon icon;
  final Function onPressed;
  final ShapeBorder shape;
  final EdgeInsets padding;
  final Color color;
  final double elevation;
  final bool disabled;

  AppIconButton({
    @required this.icon,
    this.onPressed,
    this.shape,
    this.padding = const EdgeInsets.all(0.0),
    this.color = Constants.firstElevation,
    this.elevation = 2.0,
    this.disabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
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
        foregroundColor: MaterialStateProperty.all(Constants.primaryColor),
        padding: MaterialStateProperty.all(padding),
        overlayColor: MaterialStateProperty.all(color),
        shadowColor: MaterialStateProperty.all(Constants.backgroundColor),
        minimumSize: MaterialStateProperty.all(Size(0.0, 0.0)),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        elevation: MaterialStateProperty.all(elevation),
        shape: MaterialStateProperty.all(
          shape ??
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4.0),
              ),
        ),
      ),
      child: icon,
      onPressed: !disabled ? onPressed : null,
    );
  }
}
