import 'package:client/utils/constants.dart';
import 'package:flutter/material.dart';

class AppCheckbox extends StatefulWidget {
  final bool initialValue;
  final Function onChanged;

  AppCheckbox({
    required this.initialValue,
    required this.onChanged,
  });

  @override
  _AppCheckboxState createState() => _AppCheckboxState();
}

class _AppCheckboxState extends State<AppCheckbox> {
  late bool _currentValue;

  @override
  void initState() {
    _currentValue = widget.initialValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 1.2,
      child: Checkbox(
        activeColor: Constants.primaryColor,
        checkColor: Constants.backgroundColor,
        value: _currentValue,
        onChanged: (bool? value) {
          if (value != null) {
            setState(() {
              _currentValue = value;
            });
            widget.onChanged(_currentValue);
          }
        },
      ),
    );
  }
}
