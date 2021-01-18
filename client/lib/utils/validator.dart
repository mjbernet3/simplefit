import 'package:client/utils/constants.dart';
import 'package:client/utils/structures/auth_info.dart';

class Validator {
  Validator._();

  static const String EMAIL_EMPTY = 'Please enter an email address';
  static const String EMAIL_INVALID = 'Please enter a valid email address';
  static const String USERNAME_EMPTY = 'Please enter a username';
  static const String PASSWORD_EMPTY = 'Please enter a password';
  static const String PASSWORD_SHORT =
      'Passwords must be at least 6 characters';
  static const String NO_EXERCISE_TYPE = 'Please select an exercise type';
  static const String NO_BODY_PART = 'Please select a body part';

  static void validateAuthInfo(AuthInfo authInfo) {
    validateEmail(authInfo.email);
    validateUsername(authInfo.username);
    validatePassword(authInfo.password);
  }

  static void validateEmail(String email) {
    if (email.isEmpty) {
      throw FormatException(EMAIL_EMPTY);
    } else if (!email.contains('@') || !email.contains('.')) {
      throw FormatException(EMAIL_INVALID);
    }
  }

  static void validateUsername(String username) {
    if (username.isEmpty) {
      throw FormatException(USERNAME_EMPTY);
    }
  }

  static void validatePassword(String password) {
    if (password.isEmpty) {
      throw FormatException(PASSWORD_EMPTY);
    } else if (password.length < 6) {
      throw FormatException(PASSWORD_SHORT);
    }
  }

  static String validateExerciseType(String exerciseType) {
    if (exerciseType == null) {
      return NO_EXERCISE_TYPE;
    }

    return null;
  }

  static String validateBodyPart(String bodyPart, String exerciseType) {
    if (exerciseType == Constants.lifting && bodyPart == null) {
      return NO_BODY_PART;
    }

    return null;
  }
}
