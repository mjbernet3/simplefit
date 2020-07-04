import 'package:client/app_style.dart';
import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;
  final TextInputAction textInputAction;
  final TextInputType keyboardType;
  final Function onSubmitted;
  final Color fillColor;
  final int maxLength;
  final int maxLines;
  final bool autofocus;
  final bool enabled;

  const InputField({
    this.labelText,
    this.controller,
    this.onSubmitted,
    this.fillColor = AppStyle.dp2,
    this.maxLength = TextField.noMaxLength,
    this.maxLines = 1,
    this.textInputAction = TextInputAction.next,
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
                  color: AppStyle.highEmphasisText,
                ),
              )
            : SizedBox.shrink(),
        SizedBox(height: 8.0),
        TextField(
          controller: controller,
          textInputAction: textInputAction,
          autofocus: autofocus,
          autocorrect: false,
          enabled: enabled,
          style: TextStyle(
            fontSize: 14.0,
            color: AppStyle.highEmphasisText,
          ),
          decoration: InputDecoration(
            fillColor: fillColor,
            filled: true,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppStyle.dp2),
              borderRadius: BorderRadius.all(
                Radius.circular(5.0),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppStyle.dp24),
            ),
            contentPadding: EdgeInsets.symmetric(
              vertical: 8.0,
              horizontal: 8.0,
            ),
            counterText: '',
          ),
          maxLength: maxLength,
          maxLines: maxLines,
          cursorColor: Colors.white,
          keyboardType: keyboardType,
          onSubmitted: onSubmitted,
        ),
      ],
    );
  }
}
