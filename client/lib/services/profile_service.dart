import 'package:client/models/user/user_data.dart';
import 'package:client/models/workout/workout_preview.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileService {
  final DocumentReference _userReference;

  ProfileService(_userId)
      : _userReference =
            FirebaseFirestore.instance.collection('users').doc(_userId);

  Stream<UserData> get userData => _userReference
      .snapshots()
      .map((DocumentSnapshot snapshot) => UserData.fromJson(snapshot.data()));

  void reorderPreviews(List<WorkoutPreview> previews) {
    List<dynamic> previewList =
        previews.map((preview) => preview.toJson()).toList();

    _userReference.update({
      'previews': previewList,
    });
  }
}
