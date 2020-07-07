import 'package:client/app_style.dart';
import 'package:client/components/manage_workout/distance_form.dart';
import 'package:client/components/manage_workout/lifting_form.dart';
import 'package:client/components/manage_workout/time_form.dart';
import 'package:client/components/shared/app_divider.dart';
import 'package:client/models/exercise/exercise.dart';
import 'package:flutter/material.dart';

class ExerciseForm extends StatelessWidget {
  final int index;
  final Exercise exercise;

  const ExerciseForm({
    Key key,
    this.index,
    this.exercise,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppStyle.dp2,
      padding: EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 4.0),
            child: Text(exercise.name),
          ),
          AppDivider(),
          _buildExerciseForm(),
        ],
      ),
    );
  }

  Widget _buildExerciseForm() {
    switch (exercise.type) {
      case 'Weightlifting':
        return LiftingForm();
      case 'Timed Cardio':
        return TimeForm();
      case 'Distance Cardio':
        return DistanceForm();
      default:
        return SizedBox.shrink();
    }
  }
}
