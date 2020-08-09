import 'package:client/components/exercise_detail/distance_detail.dart';
import 'package:client/components/exercise_detail/lift_detail.dart';
import 'package:client/components/exercise_detail/timed_detail.dart';
import 'package:client/models/exercise/exercise_data.dart';
import 'package:client/utils/constant.dart';
import 'package:client/view_models/distance_detail_model.dart';
import 'package:client/view_models/lift_detail_model.dart';
import 'package:client/view_models/timed_detail_model.dart';
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
        return Provider<LiftDetailModel>(
          create: (context) => LiftDetailModel(exerciseData),
          dispose: (context, model) => model.dispose(),
          child: LiftDetail(),
        );
      case Constant.timed:
        return Provider<TimedDetailModel>(
          create: (context) => TimedDetailModel(exerciseData),
          dispose: (context, model) => model.dispose(),
          child: TimedDetail(),
        );
      case Constant.distance:
        return Provider<DistanceDetailModel>(
          create: (context) => DistanceDetailModel(exerciseData),
          dispose: (context, model) => model.dispose(),
          child: DistanceDetail(),
        );
      default:
        return Container();
    }
  }
}
