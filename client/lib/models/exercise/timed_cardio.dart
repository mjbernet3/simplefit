import 'package:client/models/exercise/exercise.dart';
import 'package:client/models/exercise/exercise_data.dart';

class TimedCardio extends ExerciseData {
  int time;
  double speed;
  int repeat;
  int rest;

  TimedCardio({
    Exercise exercise,
    String notes,
    bool isWarmUp,
    this.time,
    this.speed,
    this.repeat,
    this.rest,
  }) : super(exercise, notes, isWarmUp);

  factory TimedCardio.initial(Exercise exercise) {
    return TimedCardio(
      exercise: exercise,
      notes: '',
      isWarmUp: false,
      time: 0,
      speed: 0.0,
      repeat: 0,
      rest: 0,
    );
  }

  factory TimedCardio.copy(TimedCardio other) {
    return TimedCardio(
      exercise: other.exercise,
      notes: other.notes,
      isWarmUp: other.isWarmUp,
      time: other.time,
      speed: other.speed,
      repeat: other.repeat,
      rest: other.rest,
    );
  }

  factory TimedCardio.fromJson(Map<String, dynamic> exerciseData) {
    Exercise exercise = Exercise.fromJson(exerciseData['exercise']);

    return TimedCardio(
      exercise: exercise,
      notes: exerciseData['notes'],
      isWarmUp: exerciseData['isWarmUp'],
      time: exerciseData['time'],
      speed: exerciseData['speed'],
      repeat: exerciseData['repeat'],
      rest: exerciseData['rest'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'exercise': exercise.toJson(),
      'notes': notes,
      'isWarmUp': isWarmUp,
      'time': time,
      'speed': speed,
      'repeat': repeat,
      'rest': rest,
    };
  }
}
