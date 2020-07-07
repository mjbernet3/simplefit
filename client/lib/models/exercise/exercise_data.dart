import 'package:client/models/exercise/distance_cardio.dart';
import 'package:client/models/exercise/exercise.dart';
import 'package:client/models/exercise/time_cardio.dart';
import 'package:client/models/exercise/weight_lift.dart';

abstract class ExerciseData {
  final Exercise exercise;
  final String notes;
  final int rest;
  final bool isWarmUp;

  ExerciseData(
    this.exercise,
    this.notes,
    this.rest,
    this.isWarmUp,
  );

  // Creates a concrete exercise depending on 'type' field from document
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
