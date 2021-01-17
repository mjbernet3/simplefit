import 'package:client/utils/constants.dart';
import 'package:flutter/material.dart';

class SmallInputField extends StatelessWidget {
  final String initialValue;
  final Function onChanged;
  final Color fillColor;

  const SmallInputField({
    this.initialValue,
    this.onChanged,
    this.fillColor = Constants.firstElevation,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30.0,
      width: 60.0,
      child: TextFormField(
        initialValue: initialValue,
        maxLength: 4,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        textAlignVertical: TextAlignVertical.center,
        style: TextStyle(fontSize: 14.0),
        cursorColor: Constants.highEmphasis,
        decoration: InputDecoration(
          fillColor: fillColor,
          filled: true,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: fillColor),
            borderRadius: BorderRadius.all(
              Radius.circular(5.0),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Constants.thirdElevation,
            ),
          ),
          contentPadding: EdgeInsets.symmetric(
            vertical: 8.0,
            horizontal: 8.0,
          ),
          counterText: '',
        ),
        onChanged: onChanged,
      ),
    );
  }
}
