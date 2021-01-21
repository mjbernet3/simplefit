import 'package:client/models/exercise/exercise.dart';
import 'package:client/models/exercise/exercise_data.dart';

class DistanceCardio extends ExerciseData {
  double distance;
  double speed;

  DistanceCardio({
    Exercise exercise,
    String notes,
    int rest,
    bool isWarmUp,
    bool shouldAdvance,
    this.distance,
    this.speed,
  }) : super(exercise, notes, rest, isWarmUp, shouldAdvance);

  factory DistanceCardio.initial(Exercise exercise) {
    return DistanceCardio(
      exercise: exercise,
      notes: '',
      rest: 0,
      isWarmUp: false,
      shouldAdvance: false,
      distance: 0.0,
      speed: 0.0,
    );
  }

  factory DistanceCardio.fromJson(Map<String, dynamic> json) {
    Exercise exercise = Exercise.fromJson(json['exercise']);

    return DistanceCardio(
      exercise: exercise,
      notes: json['notes'],
      rest: json['rest'],
      isWarmUp: json['isWarmUp'],
      shouldAdvance: json['shouldAdvance'],
      distance: json['distance'],
      speed: json['speed'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'exercise': exercise.toJson(),
      'notes': notes,
      'rest': rest,
      'isWarmUp': isWarmUp,
      'shouldAdvance': shouldAdvance,
      'distance': double.parse(distance.toStringAsFixed(1)),
      'speed': double.parse(speed.toStringAsFixed(1)),
    };
  }

  DistanceCardio clone() {
    return DistanceCardio(
      exercise: exercise,
      notes: notes,
      rest: rest,
      isWarmUp: isWarmUp,
      shouldAdvance: shouldAdvance,
      distance: distance,
      speed: speed,
    );
  }
}
