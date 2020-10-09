import 'package:client/components/exercise_detail/distance_detail.dart';
import 'package:client/components/exercise_detail/lift_detail.dart';
import 'package:client/components/exercise_detail/timed_detail.dart';
import 'package:client/models/exercise/distance_cardio.dart';
import 'package:client/models/exercise/exercise_data.dart';
import 'package:client/models/exercise/timed_cardio.dart';
import 'package:client/models/exercise/weight_lift.dart';
import 'package:client/utils/constant.dart';
import 'package:client/view_models/lift_detail_model.dart';
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
        WeightLift liftData = WeightLift.copy(exerciseData);
        return Provider<LiftDetailModel>(
          create: (context) => LiftDetailModel(liftData),
          dispose: (context, model) => model.dispose(),
          child: LiftDetail(liftData),
        );
      case Constant.timed:
        TimedCardio timedData = TimedCardio.copy(exerciseData);
        return TimedDetail(timedData);
      case Constant.distance:
        DistanceCardio distanceData = DistanceCardio.copy(exerciseData);
        return DistanceDetail(distanceData);
      default:
        return Container();
    }
  }
}
