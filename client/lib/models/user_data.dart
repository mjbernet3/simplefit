import 'package:client/models/workout_preview.dart';

class UserData {
  final String username;
  final int workoutCount;
  final List<WorkoutPreview> workouts;

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

  factory UserData.fromJson(Map<String, dynamic> userData) {
    List<dynamic> workoutList = userData['workouts'] as List;

    List<WorkoutPreview> workouts =
        workoutList.map((workout) => WorkoutPreview.fromJson(workout)).toList();

    return UserData(
      username: userData['username'],
      workoutCount: userData['workoutCount'],
      workouts: workouts,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'workoutCount': workoutCount,
      'workouts': workouts,
    };
  }
}
