import 'package:client/models/abstract/exercise.dart';

class Cardio extends Exercise {
  int time;
  int distance;
  int speed;
  int repeat;

  Cardio({
    String name,
    String type,
    String notes,
    int rest,
    bool isWarmUp,
    this.time,
    this.distance,
    this.speed,
    this.repeat,
  }) : super(name, type, notes, rest, isWarmUp);

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'type': type,
      'notes': notes,
      'rest': rest,
      'isWarmUp': isWarmUp,
      'time': time,
      'distance': distance,
      'speed': speed,
      'repeat': repeat,
    };
  }
}
