import 'package:client/utils/app_style.dart';
import 'package:client/components/shared/app_divider.dart';
import 'package:client/components/shared/rounded_button.dart';
import 'package:flutter/material.dart';

class ActionButtons extends StatelessWidget {
  final Function onConfirmed;
  final Color color;
  final String confirmText;
  final bool disabled;

  const ActionButtons({
    this.onConfirmed,
    this.color = AppStyle.firstElevation,
    this.confirmText = 'Save Changes',
    this.disabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        AppDivider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            RoundedButton(
              buttonText: Text(
                'Cancel',
                style: TextStyle(color: AppStyle.highEmphasis),
              ),
              height: 30.0,
              color: color,
              borderColor: color,
              disabled: disabled,
              onPressed: () => Navigator.pop(context),
            ),
            RoundedButton(
              buttonText: Text(
                confirmText,
                style: TextStyle(color: AppStyle.highEmphasis),
              ),
              height: 30.0,
              color: color,
              borderColor: color,
              disabled: disabled,
              onPressed: onConfirmed,
            ),
          ],
        ),
      ],
    );
  }
}
