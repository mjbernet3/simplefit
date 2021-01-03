import 'package:client/models/exercise/exercise.dart';
import 'package:client/models/exercise/exercise_data.dart';

class DistanceCardio extends ExerciseData {
  double distance;
  double speed;
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

  factory DistanceCardio.initial(Exercise exercise) {
    return DistanceCardio(
      exercise: exercise,
      notes: '',
      rest: 0,
      isWarmUp: false,
      distance: 0.0,
      speed: 0.0,
      repeat: 0,
    );
  }

  factory DistanceCardio.copy(DistanceCardio other) {
    return DistanceCardio(
      exercise: other.exercise,
      notes: other.notes,
      rest: other.rest,
      isWarmUp: other.isWarmUp,
      distance: other.distance,
      speed: other.speed,
      repeat: other.repeat,
    );
  }

  factory DistanceCardio.fromJson(Map<String, dynamic> exerciseData) {
    Exercise exercise = Exercise.fromJson(exerciseData['exercise']);

    return DistanceCardio(
      exercise: exercise,
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
      'exercise': exercise.toJson(),
      'notes': notes,
      'rest': rest,
      'isWarmUp': isWarmUp,
      'distance': distance,
      'speed': speed,
      'repeat': repeat,
    };
  }
}
