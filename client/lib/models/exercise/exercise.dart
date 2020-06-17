import 'package:client/models/exercise/distance_cardio.dart';
import 'package:client/models/exercise/time_cardio.dart';
import 'package:client/models/exercise/weight_lift.dart';

abstract class Exercise {
  final String name;
  final String type;
  final String notes;
  final int rest;
  final bool isWarmUp;

  Exercise(
    this.name,
    this.type,
    this.notes,
    this.rest,
    this.isWarmUp,
  );

  // Creates a concrete exercise depending on 'type' field from document
  factory Exercise.fromJson(Map<String, dynamic> exerciseData) {
    String exerciseType = exerciseData['type'];

    switch (exerciseType) {
      case 'Lifting':
        return WeightLift.fromJson(exerciseData);
      case 'TimeCardio':
        return TimeCardio.fromJson(exerciseData);
      case 'DistanceCardio':
        return DistanceCardio.fromJson(exerciseData);
      default:
        return null;
    }
  }

  Map<String, dynamic> toJson();
}
