import 'package:client/utils/constants.dart';
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
    this.fillColor = Constants.firstElevation,
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
                  color: Constants.medEmphasis,
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
          style: TextStyle(fontSize: 14.0),
          decoration: InputDecoration(
            fillColor: fillColor,
            filled: true,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Constants.firstElevation),
              borderRadius: BorderRadius.all(
                Radius.circular(5.0),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Constants.thirdElevation),
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
          cursorColor: Constants.highEmphasis,
          keyboardType: keyboardType,
          validator: validator,
          onFieldSubmitted: onSubmitted,
        ),
      ],
    );
  }
}
