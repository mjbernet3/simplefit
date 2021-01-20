import 'package:client/models/exercise/exercise.dart';
import 'package:client/models/workout/workout.dart';
import 'package:client/utils/constants.dart';
import 'package:client/utils/structures/auth_info.dart';

class Validator {
  Validator._();

  static const String EMAIL_EMPTY = 'Please enter an email address';
  static const String EMAIL_INVALID = 'Please enter a valid email address';
  static const String EMAIL_LONG =
      'Emails must be less than ${Constants.maxEmailLength} characters';
  static const String USERNAME_EMPTY = 'Please enter a username';
  static const String USERNAME_LONG =
      'Usernames must be less than ${Constants.maxUsernameLength} characters';
  static const String PASSWORD_EMPTY = 'Please enter a password';
  static const String PASSWORD_SHORT =
      'Passwords must be at least ${Constants.minPasswordLength} characters';
  static const String PASSWORD_LONG =
      'Passwords must be less than ${Constants.maxPasswordLength} characters';
  static const String EXERCISE_LONG =
      'Exercise names must be less than ${Constants.maxExerciseNameLength} characters';
  static const String NO_EXERCISE_TYPE = 'Please select an exercise type';
  static const String NO_BODY_PART = 'Please select a body part';
  static const String WORKOUT_LONG =
      'Workout names must be less than ${Constants.maxWorkoutNameLength} characters';
  static const String NO_WORKOUT_EXERCISES =
      'Workouts must have at least 1 exercise';
  static const String TOO_MANY_EXERCISES =
      'Workouts must have less than ${Constants.maxWorkoutExercises} exercises';

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
    } else if (email.length > Constants.maxEmailLength) {
      throw FormatException(EMAIL_LONG);
    }
  }

  static void validateUsername(String username) {
    if (username.isEmpty) {
      throw FormatException(USERNAME_EMPTY);
    } else if (username.length > Constants.maxUsernameLength) {
      throw FormatException(USERNAME_LONG);
    }
  }

  static void validatePassword(String password) {
    if (password.isEmpty) {
      throw FormatException(PASSWORD_EMPTY);
    } else if (password.length < Constants.minPasswordLength) {
      throw FormatException(PASSWORD_SHORT);
    } else if (password.length > Constants.maxPasswordLength) {
      throw FormatException(PASSWORD_LONG);
    }
  }

  static void validateExercise(Exercise exercise) {
    if (exercise.name.length > Constants.maxExerciseNameLength) {
      throw FormatException(EXERCISE_LONG);
    }

    validateExerciseType(exercise.type);
    validateBodyPart(exercise.type, exercise.bodyPart);
  }

  static void validateExerciseType(String exerciseType) {
    if (exerciseType == null) {
      throw FormatException(NO_EXERCISE_TYPE);
    }
  }

  static void validateBodyPart(String bodyPart, String exerciseType) {
    if (exerciseType == Constants.lifting && bodyPart == null) {
      throw FormatException(NO_BODY_PART);
    }
  }

  static void validateWorkout(Workout workout) {
    if (workout.name.length > Constants.maxWorkoutNameLength) {
      throw FormatException(WORKOUT_LONG);
    } else if (workout.exercises.length <= 0) {
      throw FormatException(NO_WORKOUT_EXERCISES);
    } else if (workout.exercises.length > Constants.maxWorkoutExercises) {
      throw FormatException(TOO_MANY_EXERCISES);
    }
  }
}
