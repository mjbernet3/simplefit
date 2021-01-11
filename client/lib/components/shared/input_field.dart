import 'package:client/utils/app_style.dart';
import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final TextEditingController controller;
  final TextInputAction textInputAction;
  final TextInputType keyboardType;
  final Function onSubmitted;
  final Function validator;
  final Color fillColor;
  final int maxLength;
  final int maxLines;
  final bool autofocus;
  final bool enabled;

  const InputField({
    this.labelText,
    this.hintText,
    this.controller,
    this.onSubmitted,
    this.validator,
    this.maxLength,
    this.fillColor = AppStyle.firstElevation,
    this.maxLines = 1,
    this.textInputAction = TextInputAction.done,
    this.keyboardType = TextInputType.text,
    this.autofocus = false,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        labelText != null
            ? Text(
                labelText,
                style: TextStyle(
                  fontSize: 14.0,
                  color: AppStyle.medEmphasis,
                ),
              )
            : SizedBox.shrink(),
        SizedBox(height: 8.0),
        TextFormField(
          controller: controller,
          textInputAction: textInputAction,
          autofocus: autofocus,
          autocorrect: false,
          enabled: enabled,
          style: TextStyle(
            fontSize: 14.0,
            color: AppStyle.highEmphasis,
          ),
          decoration: InputDecoration(
            fillColor: fillColor,
            filled: true,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppStyle.firstElevation),
              borderRadius: BorderRadius.all(
                Radius.circular(5.0),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppStyle.thirdElevation),
            ),
            contentPadding: EdgeInsets.symmetric(
              vertical: 8.0,
              horizontal: 8.0,
            ),
            counterText: '',
            hintText: hintText,
          ),
          maxLength: maxLength,
          maxLines: maxLines,
          cursorColor: Colors.white,
          keyboardType: keyboardType,
          validator: validator,
          onFieldSubmitted: onSubmitted,
        ),
      ],
    );
  }
}
