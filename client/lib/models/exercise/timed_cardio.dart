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

  factory TimedCardio.fromJson(Map<String, dynamic> exerciseData) {
    return TimedCardio(
      exercise: exerciseData['exercise'],
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
      'exercise': exercise,
      'notes': notes,
      'isWarmUp': isWarmUp,
      'time': time,
      'speed': speed,
      'repeat': repeat,
      'rest': rest,
    };
  }
}
