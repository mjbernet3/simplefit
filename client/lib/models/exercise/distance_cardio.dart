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

  factory DistanceCardio.fromJson(Map<String, dynamic> exerciseData) {
    Exercise exercise = Exercise.fromJson(exerciseData['exercise']);

    return DistanceCardio(
      exercise: exercise,
      notes: exerciseData['notes'],
      rest: exerciseData['rest'],
      isWarmUp: exerciseData['isWarmUp'],
      shouldAdvance: exerciseData['shouldAdvance'],
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

  void printExercise() {
    print(exercise.name);
    print(notes);
    print(rest);
    print(isWarmUp);
    print(shouldAdvance);
    print(distance);
    print(speed);
  }
}
