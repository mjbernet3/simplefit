import 'package:client/models/exercise/distance_cardio.dart';
import 'package:client/models/exercise/exercise.dart';
import 'package:client/models/exercise/time_cardio.dart';
import 'package:client/models/exercise/weight_lift.dart';

abstract class ExerciseData {
  Exercise exercise;
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
      case 'Weightlifting':
        return WeightLift.initial(exercise);
      case 'Timed Cardio':
        return TimeCardio.initial(exercise);
      case 'Distance Cardio':
        return DistanceCardio.initial(exercise);
      default:
        return null;
    }
  }

  factory ExerciseData.fromJson(Map<String, dynamic> exerciseData) {
    String exerciseType = exerciseData['type'];

    /*
      TODO: Having these strings everywhere is going to be a problem if you need to change one, refactor
     */
    switch (exerciseType) {
      case 'Weightlifting':
        return WeightLift.fromJson(exerciseData);
      case 'Timed Cardio':
        return TimeCardio.fromJson(exerciseData);
      case 'Distance Cardio':
        return DistanceCardio.fromJson(exerciseData);
      default:
        return null;
    }
  }

  Map<String, dynamic> toJson();
}
