import 'package:client/utils/app_style.dart';
import 'package:flutter/material.dart';

class ControlButton extends StatefulWidget {
  final bool visible;
  final Function onPressed;

  const ControlButton({
    this.visible = true,
    this.onPressed,
  });

  @override
  _ControlButtonState createState() => _ControlButtonState();
}

class _ControlButtonState extends State<ControlButton> {
  bool _isPaused = false;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: widget.visible,
      child: RawMaterialButton(
        padding: EdgeInsets.all(15.0),
        fillColor: _isPaused ? AppStyle.dp4 : AppStyle.primaryColor,
        shape: CircleBorder(),
        child: _isPaused
            ? Icon(
                Icons.pause_rounded,
                color: Colors.white,
                size: 40.0,
              )
            : Icon(
                Icons.play_arrow_rounded,
                color: AppStyle.backgroundColor,
                size: 40.0,
              ),
        onPressed: () => {
          setState(() => _isPaused = !_isPaused),
          widget.onPressed(),
        },
      ),
    );
  }
}
