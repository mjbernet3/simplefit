import 'package:client/models/workout/workout_preview.dart';

// Extra user data that is not part of firebase user object
class UserData {
  final String username;
  final List<WorkoutPreview> previews;

  UserData({
    this.username,
    this.previews,
  });

  factory UserData.initial(String username) {
    return UserData(
      username: username,
      previews: [],
    );
  }

  factory UserData.fromJson(Map<String, dynamic> json) {
    List<dynamic> previewList = json['previews'] as List;

    List<WorkoutPreview> previews =
        previewList.map((preview) => WorkoutPreview.fromJson(preview)).toList();

    return UserData(
      username: json['username'],
      previews: previews,
    );
  }

  Map<String, dynamic> toJson() {
    List<dynamic> previewList =
        previews.map((preview) => preview.toJson()).toList();

    return {
      'username': username,
      'previews': previewList,
    };
  }
}
