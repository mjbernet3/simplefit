import 'package:client/utils/constants.dart';
import 'package:flutter/material.dart';

class RemovableCard extends StatelessWidget {
  final Widget child;
  final GestureTapCallback onPressed;
  final GestureTapCallback onRemovePressed;
  final Color color;
  final Color borderColor;
  final bool isRemovable;

  RemovableCard({
    required this.child,
    required this.onPressed,
    required this.onRemovePressed,
    this.color = Constants.firstElevation,
    this.borderColor = Constants.firstElevation,
    this.isRemovable = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        isRemovable
            ? Expanded(
                flex: 1,
                child: GestureDetector(
                  onTap: onRemovePressed,
                  child: const Icon(
                    Icons.remove_circle,
                    color: Constants.dangerColor,
                  ),
                ),
              )
            : const SizedBox.shrink(),
        Expanded(
          flex: 10,
          child: GestureDetector(
            onTap: onPressed,
            child: Card(
              margin: const EdgeInsets.all(5.0),
              color: color,
              shape: RoundedRectangleBorder(
                side: BorderSide(color: borderColor),
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: child,
            ),
          ),
        ),
      ],
    );
  }
}
