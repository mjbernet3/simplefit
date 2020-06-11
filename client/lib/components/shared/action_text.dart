import 'package:flutter/material.dart';

class ActionText extends StatelessWidget {
  final Text text;
  final EdgeInsetsGeometry padding;
  final Function onPressed;

  const ActionText({
    @required this.text,
    @required this.onPressed,
    this.padding = const EdgeInsets.all(0.0),
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: GestureDetector(
        child: text,
        onTap: onPressed,
      ),
    );
  }
}
