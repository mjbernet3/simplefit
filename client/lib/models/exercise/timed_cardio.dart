import 'package:client/models/exercise/exercise.dart';
import 'package:client/models/exercise/exercise_data.dart';

class TimedCardio extends ExerciseData {
  int time;
  double speed;

  TimedCardio({
    Exercise exercise,
    String notes,
    int rest,
    bool isWarmUp,
    bool shouldAdvance,
    this.time,
    this.speed,
  }) : super(exercise, notes, rest, isWarmUp, shouldAdvance);

  factory TimedCardio.initial(Exercise exercise) {
    return TimedCardio(
      exercise: exercise,
      notes: '',
      rest: 0,
      isWarmUp: false,
      shouldAdvance: false,
      time: 0,
      speed: 0.0,
    );
  }

  factory TimedCardio.fromJson(Map<String, dynamic> exerciseData) {
    Exercise exercise = Exercise.fromJson(exerciseData['exercise']);

    return TimedCardio(
      exercise: exercise,
      notes: exerciseData['notes'],
      rest: exerciseData['rest'],
      isWarmUp: exerciseData['isWarmUp'],
      shouldAdvance: exerciseData['shouldAdvance'],
      time: exerciseData['time'],
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
      'time': time,
      'speed': double.parse(speed.toStringAsFixed(1)),
    };
  }

  TimedCardio clone() {
    return TimedCardio(
      exercise: exercise,
      notes: notes,
      rest: rest,
      isWarmUp: isWarmUp,
      shouldAdvance: shouldAdvance,
      time: time,
      speed: speed,
    );
  }

  void printExercise() {
    print(exercise.name);
    print(notes);
    print(rest);
    print(isWarmUp);
    print(shouldAdvance);
    print(time);
    print(speed);
  }
}
