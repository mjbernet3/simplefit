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
  final Color color;
  final Color focusBorderColor;
  final int maxLength;
  final int numLines;
  final bool autofocus;
  final bool enabled;

  InputField({
    this.labelText,
    this.hintText,
    this.controller,
    this.onSubmitted,
    this.validator,
    this.maxLength,
    this.color = Constants.firstElevation,
    this.focusBorderColor = Constants.thirdElevation,
    this.numLines = 1,
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
            fillColor: color,
            filled: true,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: color),
              borderRadius: BorderRadius.all(
                Radius.circular(4.0),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: focusBorderColor),
            ),
            contentPadding: EdgeInsets.symmetric(
              vertical: 8.0,
              horizontal: 8.0,
            ),
            counterText: '',
            hintText: hintText,
          ),
          maxLength: maxLength,
          maxLines: numLines,
          minLines: numLines,
          cursorColor: Constants.highEmphasis,
          keyboardType: keyboardType,
          validator: validator,
          onFieldSubmitted: onSubmitted,
        ),
      ],
    );
  }
}
