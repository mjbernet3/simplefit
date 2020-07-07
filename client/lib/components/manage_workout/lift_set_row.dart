import 'package:client/app_style.dart';
import 'package:client/components/shared/small_input_field.dart';
import 'package:client/models/exercise/lift_set.dart';
import 'package:flutter/material.dart';

class LiftSetRow extends StatelessWidget {
  final int index;

  const LiftSetRow({this.index});

  @override
  Widget build(BuildContext context) {
    LiftSet newSet = LiftSet();

    return Row(
      children: <Widget>[
        Container(
          height: 30.0,
          width: 30.0,
          decoration: BoxDecoration(
            color: AppStyle.dp8,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              index.toString(),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 30.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                SmallInputField(
                  onChanged: (String value) => newSet.reps = int.parse(value),
                ),
                SmallInputField(
                  onChanged: (String value) => newSet.weight = int.parse(value),
                ),
                SmallInputField(
                  onChanged: (String value) => newSet.rest = int.parse(value),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
