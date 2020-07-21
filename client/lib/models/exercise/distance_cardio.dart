import 'package:client/models/exercise/exercise.dart';
import 'package:client/models/exercise/exercise_data.dart';

class DistanceCardio extends ExerciseData {
  double distance;
  double speed;
  int repeat;
  int rest;

  DistanceCardio({
    Exercise exercise,
    String notes,
    bool isWarmUp,
    this.distance,
    this.speed,
    this.repeat,
    this.rest,
  }) : super(exercise, notes, isWarmUp);

  factory DistanceCardio.initial(Exercise exercise) {
    return DistanceCardio(
      exercise: exercise,
      notes: '',
      isWarmUp: false,
      distance: 0.0,
      speed: 0.0,
      repeat: 0,
      rest: 0,
    );
  }

  factory DistanceCardio.fromJson(Map<String, dynamic> exerciseData) {
    return DistanceCardio(
      exercise: exerciseData['exercise'],
      notes: exerciseData['notes'],
      isWarmUp: exerciseData['isWarmUp'],
      distance: exerciseData['distance'],
      speed: exerciseData['speed'],
      repeat: exerciseData['repeat'],
      rest: exerciseData['rest'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'exercise': exercise,
      'notes': notes,
      'isWarmUp': isWarmUp,
      'distance': distance,
      'speed': speed,
      'repeat': repeat,
      'rest': rest,
    };
  }
}
