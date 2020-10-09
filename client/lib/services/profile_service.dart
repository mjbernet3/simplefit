import 'package:client/models/user/user_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileService {
  final String _userId;
  final CollectionReference _userCollection =
      Firestore.instance.collection('users');

  ProfileService(this._userId);

  Stream<UserData> get userData {
    return _userCollection
        .document(_userId)
        .snapshots()
        .map((DocumentSnapshot snapshot) {
      return UserData.fromJson(snapshot.data);
    });
  }
}
