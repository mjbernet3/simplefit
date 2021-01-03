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
    this.distance,
    this.speed,
  }) : super(exercise, notes, rest, isWarmUp);

  factory DistanceCardio.initial(Exercise exercise) {
    return DistanceCardio(
      exercise: exercise,
      notes: '',
      rest: 0,
      isWarmUp: false,
      distance: 0.0,
      speed: 0.0,
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
    };
  }

  DistanceCardio copy() {
    return DistanceCardio(
      exercise: exercise,
      notes: notes,
      rest: rest,
      isWarmUp: isWarmUp,
      distance: distance,
      speed: speed,
    );
  }
}
