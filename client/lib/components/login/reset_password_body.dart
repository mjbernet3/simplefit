import 'package:client/components/shared/input_field.dart';
import 'package:client/services/auth_service.dart';
import 'package:client/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ResetPasswordBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Reset Password',
          style: TextStyle(fontSize: 18.0),
        ),
        const SizedBox(height: 10.0),
        const Text(
          'Enter your email to receive a link to reset your password.',
          style: TextStyle(color: Constants.medEmphasis),
        ),
        const SizedBox(height: 10.0),
        InputField(
          color: Constants.secondElevation,
          maxLength: Constants.maxEmailLength,
          autofocus: true,
          onSubmitted: (String email) => _resetPassword(context, email),
        ),
      ],
    );
  }

  void _resetPassword(BuildContext context, String email) async {
    AuthService authService = Provider.of<AuthService>(context, listen: false);

    try {
      await authService.resetPassword(email);
      Navigator.pop(context);
    } catch (e) {
      Navigator.pop(context, e.message);
    }
  }
}
