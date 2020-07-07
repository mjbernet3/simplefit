import 'package:client/app_style.dart';
import 'package:client/components/manage_workout/lift_set_row.dart';
import 'package:client/components/shared/rounded_button.dart';
import 'package:flutter/material.dart';

class LiftingForm extends StatefulWidget {
  @override
  _LiftingFormState createState() => _LiftingFormState();
}

class _LiftingFormState extends State<LiftingForm> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        LiftSetRow(index: 1),
        RoundedButton(
          buttonText: Text(
            'Add Set',
            style: TextStyle(
              color: AppStyle.highEmphasisText,
            ),
          ),
          height: 30.0,
          color: AppStyle.dp4,
          borderColor: AppStyle.dp4,
          onPressed: () => print('add a set'),
        ),
      ],
    );
  }
}
