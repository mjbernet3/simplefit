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
  bool shouldAdvance;

  ExerciseData(
    this.exercise,
    this.notes,
    this.rest,
    this.isWarmUp,
    this.shouldAdvance,
  );

  factory ExerciseData.initial(Exercise exercise) {
    String exerciseType = exercise.type;

    switch (exerciseType) {
      case Constants.lifting:
        return WeightLift.initial(exercise);
      case Constants.timed:
        return TimedCardio.initial(exercise);
      case Constants.distance:
        return DistanceCardio.initial(exercise);
      default:
        return null;
    }
  }

  factory ExerciseData.fromJson(Map<String, dynamic> exerciseData) {
    String exerciseType = exerciseData['exercise']['type'];

    switch (exerciseType) {
      case Constants.lifting:
        return WeightLift.fromJson(exerciseData);
      case Constants.timed:
        return TimedCardio.fromJson(exerciseData);
      case Constants.distance:
        return DistanceCardio.fromJson(exerciseData);
      default:
        return null;
    }
  }

  Map<String, dynamic> toJson();

  ExerciseData clone();

  // TODO: For debugging, remove implementations later
  void printExercise();
}
