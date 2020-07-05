import 'package:client/app_style.dart';
import 'package:client/components/exercise_browse/exercise_listing.dart';
import 'package:client/components/shared/app_divider.dart';
import 'package:client/components/shared/rounded_button.dart';
import 'package:client/router.dart';
import 'package:flutter/material.dart';

class ExerciseBrowsePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        ExerciseListing(),
        AppDivider(),
        RoundedButton(
          buttonText: Text(
            'Create Exercise',
            style: TextStyle(color: AppStyle.highEmphasisText),
          ),
          height: 30.0,
          color: AppStyle.dp4,
          borderColor: AppStyle.dp4,
          onPressed: () => Navigator.pushNamed(context, Router.createExercise),
        ),
      ],
    );
  }
}
