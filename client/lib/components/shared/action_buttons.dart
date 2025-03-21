import 'package:client/utils/constants.dart';
import 'package:client/components/shared/rounded_button.dart';
import 'package:flutter/material.dart';

class ActionButtons extends StatelessWidget {
  final VoidCallback onConfirmed;
  final Color color;
  final String confirmText;
  final bool disabled;

  ActionButtons({
    required this.onConfirmed,
    this.color = Constants.firstElevation,
    this.confirmText = 'Save Changes',
    this.disabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            RoundedButton(
              buttonText: 'Cancel',
              height: 35.0,
              color: color,
              disabled: disabled,
              onPressed: () => Navigator.pop(context),
            ),
            RoundedButton(
              buttonText: confirmText,
              height: 35.0,
              color: color,
              disabled: disabled,
              onPressed: onConfirmed,
            ),
          ],
        ),
      ],
    );
  }
}
