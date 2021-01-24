import 'package:client/models/user/app_user.dart';
import 'package:client/models/user/user_data.dart';
import 'package:client/utils/structures/auth_info.dart';
import 'package:client/utils/validator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final CollectionReference _userCollection =
      FirebaseFirestore.instance.collection('users');

  Stream<AppUser> get signedInUser =>
      _firebaseAuth.authStateChanges().map((User firebaseUser) {
        if (firebaseUser == null) {
          return null;
        }

        return AppUser(
          uid: firebaseUser.uid,
          email: firebaseUser.email,
          emailVerified: firebaseUser.emailVerified,
        );
      });

  Future<void> register(AuthInfo authInfo) async {
    Validator.validateAuthInfo(authInfo);

    await _checkForUsername(authInfo.username);

    UserCredential result = await _firebaseAuth.createUserWithEmailAndPassword(
      email: authInfo.email,
      password: authInfo.password,
    );

    if (result.user == null) {
      throw Exception("User is null after successful registration.");
    }

    UserData userData = UserData.initial(authInfo.username);

    await _userCollection.doc(result.user.uid).set(userData.toJson());
  }

  Future<void> _checkForUsername(String username) async {
    QuerySnapshot userQuery =
        await _userCollection.where('username', isEqualTo: username).get();

    if (userQuery.docs.isNotEmpty) {
      throw Exception('Username is taken. Please enter a different one.');
    }
  }

  Future<void> signIn(AuthInfo authInfo) async {
    UserCredential result = await _firebaseAuth.signInWithEmailAndPassword(
      email: authInfo.email,
      password: authInfo.password,
    );

    if (result.user == null) {
      throw Exception("User is null after successful sign in.");
    }
  }

  Future<void> resetPassword(String email) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
