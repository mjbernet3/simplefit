import 'package:client/utils/app_style.dart';
import 'package:flutter/material.dart';

class AuthInputField extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;
  final TextInputAction textInputAction;
  final TextInputType keyboardType;
  final Function validator;
  final Function onSubmitted;
  final bool hidden;
  final bool autofocus;
  final bool enabled;

  const AuthInputField({
    @required this.labelText,
    this.controller,
    this.validator,
    this.onSubmitted,
    this.textInputAction = TextInputAction.done,
    this.keyboardType = TextInputType.text,
    this.hidden = false,
    this.autofocus = false,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          labelText,
          style: TextStyle(color: AppStyle.medEmphasisText),
        ),
        TextFormField(
          controller: controller,
          textInputAction: textInputAction,
          autofocus: autofocus,
          autocorrect: false,
          enabled: enabled,
          obscureText: hidden,
          maxLength: 30,
          cursorColor: Colors.white,
          style: TextStyle(
            fontSize: 14.0,
            color: AppStyle.highEmphasisText,
          ),
          decoration: InputDecoration(
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            contentPadding: EdgeInsets.symmetric(
              vertical: 0.0,
              horizontal: 2.0,
            ),
            counterText: '',
          ),
          keyboardType: keyboardType,
          validator: validator,
          onFieldSubmitted: onSubmitted,
        ),
      ],
    );
  }
}
