import 'package:client/app_style.dart';
import 'package:flutter/material.dart';

class SmallInputField extends StatelessWidget {
  final String initialValue;
  final Function onChanged;

  const SmallInputField({
    this.onChanged,
    this.initialValue,
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
          color: AppStyle.highEmphasisText,
        ),
        cursorColor: AppStyle.dp8,
        decoration: InputDecoration(
          fillColor: AppStyle.dp8,
          filled: true,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppStyle.dp2),
            borderRadius: BorderRadius.all(
              Radius.circular(5.0),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
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
