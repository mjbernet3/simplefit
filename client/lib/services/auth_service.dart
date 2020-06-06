import 'package:client/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<User> get signedInUser {
    return _auth.onAuthStateChanged.map((FirebaseUser firebaseUser) {
      if (firebaseUser == null) {
        return null;
      }

      return User(
        uid: firebaseUser.uid,
        email: firebaseUser.email,
        displayName: firebaseUser.displayName,
      );
    });
  }
}
