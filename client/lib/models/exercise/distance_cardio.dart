import 'package:client/models/exercise/exercise.dart';
import 'package:client/models/exercise/exercise_data.dart';

class DistanceCardio extends ExerciseData {
  int distance;
  int speed;
  int repeat;

  DistanceCardio({
    Exercise exercise,
    String notes,
    int rest,
    bool isWarmUp,
    this.distance,
    this.speed,
    this.repeat,
  }) : super(exercise, notes, rest, isWarmUp);

  factory DistanceCardio.fromJson(Map<String, dynamic> exerciseData) {
    return DistanceCardio(
      exercise: exerciseData['exercise'],
      notes: exerciseData['notes'],
      rest: exerciseData['rest'],
      isWarmUp: exerciseData['isWarmUp'],
      distance: exerciseData['distance'],
      speed: exerciseData['speed'],
      repeat: exerciseData['repeat'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'exercise': exercise,
      'notes': notes,
      'rest': rest,
      'isWarmUp': isWarmUp,
      'distance': distance,
      'speed': speed,
      'repeat': repeat,
    };
  }
}
