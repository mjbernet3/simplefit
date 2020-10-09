import 'package:client/app_style.dart';
import 'package:flutter/material.dart';

class WarmUpCheck extends StatefulWidget {
  final bool initialValue;
  final Function onChanged;

  const WarmUpCheck({
    this.initialValue,
    this.onChanged,
  });

  @override
  _WarmUpCheckState createState() => _WarmUpCheckState();
}

class _WarmUpCheckState extends State<WarmUpCheck> {
  bool _isWarmUp;

  @override
  void initState() {
    super.initState();
    _isWarmUp = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      activeColor: AppStyle.primaryColor,
      checkColor: AppStyle.backgroundColor,
      value: _isWarmUp,
      onChanged: (bool value) => {
        widget.onChanged(value),
        setState(() => _isWarmUp = value),
      },
    );
  }
}
