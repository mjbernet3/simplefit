import 'package:client/utils/constants.dart';
import 'package:flutter/material.dart';

class AuthInputField extends StatelessWidget {
  final String labelText;
  final int maxLength;
  final TextEditingController controller;
  final TextInputAction textInputAction;
  final TextInputType keyboardType;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onSubmitted;
  final bool hidden;
  final bool autofocus;
  final bool enabled;

  AuthInputField({
    required this.labelText,
    required this.maxLength,
    required this.controller,
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
          style: const TextStyle(color: Constants.medEmphasis),
        ),
        TextFormField(
          controller: controller,
          textInputAction: textInputAction,
          autofocus: autofocus,
          autocorrect: false,
          enabled: enabled,
          obscureText: hidden,
          maxLength: maxLength,
          cursorColor: Constants.highEmphasis,
          style: const TextStyle(fontSize: 14.0),
          decoration: const InputDecoration(
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Constants.highEmphasis),
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
