import 'package:client/models/exercise/exercise.dart';

class DistanceCardio extends Exercise {
  int distance;
  int speed;
  int repeat;

  DistanceCardio({
    String name,
    String type,
    String notes,
    int rest,
    bool isWarmUp,
    this.distance,
    this.speed,
    this.repeat,
  }) : super(name, type, notes, rest, isWarmUp);

  factory DistanceCardio.fromJson(Map<String, dynamic> exerciseData) {
    return DistanceCardio(
      name: exerciseData['name'],
      type: exerciseData['type'],
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
      'name': name,
      'type': type,
      'notes': notes,
      'rest': rest,
      'isWarmUp': isWarmUp,
      'distance': distance,
      'speed': speed,
      'repeat': repeat,
    };
  }
}
