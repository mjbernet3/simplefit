import 'package:client/models/user/user_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileService {
  final DocumentReference _userReference;

  ProfileService(_userId)
      : _userReference =
            Firestore.instance.collection('users').document(_userId);

  Stream<UserData> get userData => _userReference
      .snapshots()
      .map((DocumentSnapshot snapshot) => UserData.fromJson(snapshot.data));
}
