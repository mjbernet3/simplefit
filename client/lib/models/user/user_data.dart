import 'package:client/models/workout/workout_preview.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Extra user data that is not part of firebase user object
class UserData {
  final String username;
  final List<WorkoutPreview> previews;

  UserData({
    required this.username,
    required this.previews,
  });

  factory UserData.initial(String username) {
    return UserData(
      username: username,
      previews: [],
    );
  }

  factory UserData.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> json = snapshot.data() as Map<String, dynamic>;
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
