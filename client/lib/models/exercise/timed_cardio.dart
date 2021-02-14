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
    this.time,
    this.speed,
  }) : super(exercise, notes, rest, isWarmUp);

  factory TimedCardio.initial(Exercise exercise) {
    return TimedCardio(
      exercise: exercise,
      notes: '',
      rest: 0,
      isWarmUp: false,
      time: 0,
      speed: 0.0,
    );
  }

  factory TimedCardio.fromJson(Map<String, dynamic> json) {
    Exercise exercise = Exercise.fromJson(json['exercise']);

    return TimedCardio(
      exercise: exercise,
      notes: json['notes'],
      rest: json['rest'],
      isWarmUp: json['isWarmUp'],
      time: json['time'],
      speed: json['speed'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'exercise': exercise.toJson(),
      'notes': notes,
      'rest': rest,
      'isWarmUp': isWarmUp,
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
      time: time,
      speed: speed,
    );
  }
}
