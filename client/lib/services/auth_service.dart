import 'package:client/models/user/user.dart';
import 'package:client/models/user/user_data.dart';
import 'package:client/utils/structures/auth_info.dart';
import 'package:client/utils/validator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference _userCollection =
      Firestore.instance.collection('users');

  Stream<User> get signedInUser {
    return _auth.onAuthStateChanged.map((FirebaseUser firebaseUser) {
      if (firebaseUser == null) {
        return null;
      }

      return User(
        uid: firebaseUser.uid,
        email: firebaseUser.email,
      );
    });
  }

  Future<void> register(AuthInfo authInfo) async {
    Validator.validateAuthInfo(authInfo);

    await _checkForUsername(authInfo.username);

    AuthResult result = await _auth.createUserWithEmailAndPassword(
        email: authInfo.email, password: authInfo.password);

    if (result.user == null) {
      throw Exception("User is null after successful registration");
    }

    UserData userData = UserData.initial(authInfo.username);

    await _userCollection.document(result.user.uid).setData(userData.toJson());
  }

  Future<void> _checkForUsername(String username) async {
    QuerySnapshot userQuery = await _userCollection
        .where('username', isEqualTo: username)
        .getDocuments();

    if (userQuery.documents.isNotEmpty) {
      throw Exception('Username is taken. Please enter a different one.');
    }
  }

  Future<void> signIn(AuthInfo authInfo) async {
    AuthResult result = await _auth.signInWithEmailAndPassword(
        email: authInfo.email, password: authInfo.password);

    if (result.user == null) {
      throw Exception("User is null after successful sign in");
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
