import 'package:client/utils/app_style.dart';
import 'package:client/components/shared/app_divider.dart';
import 'package:client/components/shared/rounded_button.dart';
import 'package:flutter/material.dart';

class ActionButtons extends StatelessWidget {
  final String confirmText;
  final Function onConfirmed;
  final bool disabled;

  const ActionButtons({
    this.onConfirmed,
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
                style: TextStyle(color: AppStyle.highEmphasisText),
              ),
              height: 30.0,
              color: AppStyle.dp4,
              disabled: disabled,
              borderColor: AppStyle.dp4,
              onPressed: () => Navigator.pop(context),
            ),
            RoundedButton(
              buttonText: Text(
                confirmText,
                style: TextStyle(color: AppStyle.highEmphasisText),
              ),
              height: 30.0,
              color: AppStyle.dp4,
              disabled: disabled,
              borderColor: AppStyle.dp4,
              onPressed: onConfirmed,
            ),
          ],
        ),
      ],
    );
  }
}
