import 'package:client/models/exercise/distance_cardio.dart';
import 'package:client/models/exercise/exercise.dart';
import 'package:client/models/exercise/timed_cardio.dart';
import 'package:client/models/exercise/weight_lift.dart';
import 'package:client/utils/constant.dart';

abstract class ExerciseData {
  final Exercise exercise;
  String notes;
  int rest;
  bool isWarmUp;

  ExerciseData(
    this.exercise,
    this.notes,
    this.rest,
    this.isWarmUp,
  );

  factory ExerciseData.initial(Exercise exercise) {
    String exerciseType = exercise.type;

    switch (exerciseType) {
      case Constant.lifting:
        return WeightLift.initial(exercise);
      case Constant.timed:
        return TimedCardio.initial(exercise);
      case Constant.distance:
        return DistanceCardio.initial(exercise);
      default:
        return null;
    }
  }

  factory ExerciseData.fromJson(Map<String, dynamic> exerciseData) {
    String exerciseType = exerciseData['exercise']['type'];

    switch (exerciseType) {
      case Constant.lifting:
        return WeightLift.fromJson(exerciseData);
      case Constant.timed:
        return TimedCardio.fromJson(exerciseData);
      case Constant.distance:
        return DistanceCardio.fromJson(exerciseData);
      default:
        return null;
    }
  }

  Map<String, dynamic> toJson();
}
