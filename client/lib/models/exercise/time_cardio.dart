import 'package:client/models/exercise/exercise_data.dart';

class TimeCardio extends ExerciseData {
  final int time;
  final int speed;
  final int repeat;

  TimeCardio({
    String name,
    String type,
    String notes,
    int rest,
    bool isWarmUp,
    this.time,
    this.speed,
    this.repeat,
  }) : super(name, type, notes, rest, isWarmUp);

  factory TimeCardio.fromJson(Map<String, dynamic> exerciseData) {
    return TimeCardio(
      name: exerciseData['name'],
      type: exerciseData['type'],
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
      'name': name,
      'type': type,
      'notes': notes,
      'rest': rest,
      'isWarmUp': isWarmUp,
      'time': time,
      'speed': speed,
      'repeat': repeat,
    };
  }
}
