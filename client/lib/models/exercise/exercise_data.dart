import 'package:client/models/exercise/distance_cardio.dart';
import 'package:client/models/exercise/exercise.dart';
import 'package:client/models/exercise/timed_cardio.dart';
import 'package:client/models/exercise/weight_lift.dart';
import 'package:client/utils/constants.dart';

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
      case Constants.timed:
        return TimedCardio.initial(exercise);
      case Constants.distance:
        return DistanceCardio.initial(exercise);
      default:
        return WeightLift.initial(exercise);
    }
  }

  factory ExerciseData.fromJson(Map<String, dynamic> json) {
    String exerciseType = json['exercise']['type'];

    switch (exerciseType) {
      case Constants.timed:
        return TimedCardio.fromJson(json);
      case Constants.distance:
        return DistanceCardio.fromJson(json);
      default:
        return WeightLift.fromJson(json);
    }
  }

  Map<String, dynamic> toJson();

  ExerciseData clone();
}
