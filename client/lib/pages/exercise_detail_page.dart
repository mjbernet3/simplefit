import 'package:client/components/exercise_detail/distance_form.dart';
import 'package:client/components/exercise_detail/lift_form.dart';
import 'package:client/components/exercise_detail/timed_form.dart';
import 'package:client/models/exercise/exercise_data.dart';
import 'package:client/utils/constant.dart';
import 'package:client/view_models/lift_form_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExerciseDetailPage extends StatelessWidget {
  final ExerciseData exerciseData;

  const ExerciseDetailPage({this.exerciseData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(30.0),
          child: _buildExerciseForm(),
        ),
      ),
    );
  }

  Widget _buildExerciseForm() {
    String exerciseType = exerciseData.exercise.type;

    switch (exerciseType) {
      case Constant.lifting:
        return Provider<LiftFormModel>(
          create: (context) => LiftFormModel(exerciseData),
          dispose: (context, model) => model.dispose(),
          child: LiftForm(),
        );
      case Constant.timed:
        return TimedForm();
      case Constant.distance:
        return DistanceForm();
      default:
        return Container();
    }
  }
}
