import 'package:client/utils/app_style.dart';
import 'package:flutter/material.dart';

class SmallInputField extends StatelessWidget {
  final String initialValue;
  final Function onChanged;

  const SmallInputField({
    this.initialValue,
    this.onChanged,
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
        style: TextStyle(
          fontSize: 14.0,
          color: AppStyle.highEmphasis,
        ),
        cursorColor: AppStyle.highEmphasis,
        decoration: InputDecoration(
          fillColor: AppStyle.firstElevation,
          filled: true,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppStyle.firstElevation),
            borderRadius: BorderRadius.all(
              Radius.circular(5.0),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppStyle.highEmphasis),
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
