import 'package:client/models/user/user.dart';
import 'package:client/models/user/user_data.dart';
import 'package:client/utils/structures/auth_info.dart';
import 'package:client/utils/structures/response.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

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
        displayName: firebaseUser.displayName,
      );
    });
  }

  Future<Response> register(AuthInfo authInfo) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: authInfo.email, password: authInfo.password);

      if (result.user == null) {
        return Response(
            status: Status.FAILURE,
            message: 'User does not exist after registration');
      }

      await _initUserData(result.user.uid, authInfo.username);

      return Response(status: Status.SUCCESS);
    } on PlatformException catch (error) {
      return Response(status: Status.FAILURE, message: error.message);
    } catch (error) {
      return Response(
          status: Status.FAILURE, message: 'Unable to create an account');
    }
  }

  Future<void> _initUserData(String uid, String username) async {
    UserData userData = UserData.initial(username);

    await _userCollection.document(uid).setData(userData.toJson());
  }

  Future<Response> signIn(AuthInfo authInfo) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: authInfo.email, password: authInfo.password);

      if (result.user == null) {
        return Response(
            status: Status.FAILURE,
            message: 'User does not exist after successful sign in');
      }

      return Response(status: Status.SUCCESS);
    } on PlatformException catch (error) {
      return Response(status: Status.FAILURE, message: error.message);
    } catch (error) {
      return Response(
          status: Status.FAILURE, message: 'Unable to sign in to application');
    }
  }

  Future<Response> signOut() async {
    try {
      await _auth.signOut();
    } catch (error) {
      return Response(
          status: Status.FAILURE, message: 'Unable to sign out of application');
    }
  }
}
