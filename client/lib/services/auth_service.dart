import 'package:client/models/user.dart';
import 'package:client/utils/response.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

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

  Future<Response> signIn(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      if (result.user == null) {
        return Response(
            status: Status.FAILURE,
            message: 'User does not exist after successful sign in.');
      }

      return Response(status: Status.SUCCESS);
    } on PlatformException catch (error) {
      return Response(status: Status.FAILURE, message: error.message);
    } catch (error) {
      return Response(
          status: Status.FAILURE, message: 'Unable to sign in to application');
    }
  }
}
