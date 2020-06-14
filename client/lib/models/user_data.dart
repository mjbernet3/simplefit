import 'package:client/models/workout_preview.dart';

class UserData {
  String username;
  int workoutCount;
  List<WorkoutPreview> workouts;

  UserData({
    this.username,
    this.workoutCount,
    this.workouts,
  });

  factory UserData.initial(String username) {
    return UserData(
      username: username,
      workoutCount: 0,
      workouts: [],
    );
  }

  factory UserData.fromMap(Map<String, dynamic> userData) {
    return UserData(
      username: userData['username'],
      workoutCount: userData['workoutCount'],
      workouts: userData['workouts'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'workoutCount': workoutCount,
      'workouts': workouts,
    };
  }
}
