import 'package:client/models/user_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileService {
  final CollectionReference _userCollection =
      Firestore.instance.collection('users');

  final String _userId;

  ProfileService(this._userId);

  Stream<UserData> get userData {
    return _userCollection
        .document(_userId)
        .snapshots()
        .map((DocumentSnapshot snapshot) {
      return UserData.fromMap(snapshot.data);
    });
  }
}
