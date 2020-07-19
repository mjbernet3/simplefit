import 'package:client/models/exercise/exercise.dart';
import 'package:client/models/exercise/exercise_data.dart';

class TimeCardio extends ExerciseData {
  final int time;
  final double speed;
  final int repeat;

  TimeCardio({
    Exercise exercise,
    String notes,
    int rest,
    bool isWarmUp,
    this.time,
    this.speed,
    this.repeat,
  }) : super(exercise, notes, rest, isWarmUp);

  factory TimeCardio.initial(Exercise exercise) {
    return TimeCardio(
      exercise: exercise,
      notes: '',
      rest: 0,
      isWarmUp: false,
      time: 0,
      speed: 0.0,
      repeat: 0,
    );
  }

  factory TimeCardio.fromJson(Map<String, dynamic> exerciseData) {
    return TimeCardio(
      exercise: exerciseData['exercise'],
      notes: exerciseData['notes'],
      rest: exerciseData['rest'],
      isWarmUp: exerciseData['isWarmUp'],
      time: exerciseData['time'],
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
      'time': time,
      'speed': speed,
      'repeat': repeat,
    };
  }
}
