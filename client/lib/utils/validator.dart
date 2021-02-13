import 'package:client/models/exercise/distance_cardio.dart';
import 'package:client/models/exercise/exercise.dart';
import 'package:client/models/exercise/exercise_data.dart';
import 'package:client/models/exercise/lift_set.dart';
import 'package:client/models/exercise/timed_cardio.dart';
import 'package:client/models/exercise/weight_lift.dart';
import 'package:client/models/workout/workout.dart';
import 'package:client/utils/constants.dart';
import 'package:client/utils/structures/auth_info.dart';

class Validator {
  Validator._();

  static const String EMAIL_EMPTY = 'Please enter an email address.';
  static const String EMAIL_INVALID = 'Please enter a valid email address.';
  static const String EMAIL_LONG =
      'Emails cannot be more than ${Constants.maxEmailLength} characters.';
  static const String USERNAME_EMPTY = 'Please enter a username.';
  static const String USERNAME_LONG =
      'Usernames cannot be more than ${Constants.maxUsernameLength} characters.';
  static const String PASSWORD_EMPTY = 'Please enter a password.';
  static const String PASSWORD_SHORT =
      'Passwords must be at least ${Constants.minPasswordLength} characters.';
  static const String PASSWORD_LONG =
      'Passwords cannot be more than ${Constants.maxPasswordLength} characters.';
  static const String EXERCISE_LONG =
      'Exercise names cannot be more than ${Constants.maxExerciseNameLength} characters.';
  static const String NO_EXERCISE_TYPE = 'Please select an exercise type.';
  static const String NO_BODY_PART = 'Please select a body part.';
  static const String WORKOUT_LONG =
      'Workout names cannot be more than ${Constants.maxWorkoutNameLength} characters.';
  static const String NO_WORKOUT_EXERCISES =
      'Workouts must have at least 1 exercise.';
  static const String TOO_MANY_EXERCISES =
      'Workouts cannot have more than ${Constants.maxWorkoutExercises} exercises.';
  static const String INVALID_EXERCISE =
      'Exercise does not match any existing exercise type.';
  static const String NO_EXERCISE_SETS =
      'Weight lift exercises must have at least 1 set.';
  static const String TOO_MANY_SETS =
      'Weight lift exercises cannot have more than ${Constants.maxExerciseSets} sets.';
  static const String TOO_MANY_REPS =
      'Weight lift set cannot have more than ${Constants.maxExerciseReps} reps.';
  static const String TARGET_REPS_EXCEEDED =
      'Weight lift set reps cannot be more than target reps.';
  static const String TOO_MUCH_WEIGHT =
      'Weight lift set weight cannot be more than ${Constants.maxExerciseWeight} pounds.';
  static const String TOO_MUCH_DISTANCE =
      'Cardio distance cannot be more than ${Constants.maxExerciseDistance} miles.';
  static const String TOO_MUCH_TIME =
      'Cardio time cannot be more than ${Constants.maxExerciseTime} seconds.';
  static const String TOO_MUCH_SPEED =
      'Cardio speed cannot be more than ${Constants.maxExerciseSpeed} mph.';
  static const String TOO_MUCH_REST =
      'Exercise and set rest cannot be more than ${Constants.maxExerciseRest} seconds.';
  static const String NEGATIVE_EXERCISE_STAT =
      'Exercise and set statistics cannot be less than 0.';

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

  static void validateWorkout(Workout workout) {
    if (workout.name.length > Constants.maxWorkoutNameLength) {
      throw FormatException(WORKOUT_LONG);
    } else if (workout.exercises.length <= 0) {
      throw FormatException(NO_WORKOUT_EXERCISES);
    } else if (workout.exercises.length > Constants.maxWorkoutExercises) {
      throw FormatException(TOO_MANY_EXERCISES);
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

  static void validateExerciseData(ExerciseData exercise) {
    if (exercise.rest < 0) {
      throw FormatException(NEGATIVE_EXERCISE_STAT);
    } else if (exercise.rest > Constants.maxExerciseRest) {
      throw FormatException(TOO_MUCH_REST);
    }

    String exerciseType = exercise.exercise.type;

    switch (exerciseType) {
      case Constants.lifting:
        validateWeightLift(exercise);
        break;
      case Constants.distance:
        validateDistanceCardio(exercise);
        break;
      case Constants.timed:
        validateTimedCardio(exercise);
        break;
      default:
        throw FormatException(INVALID_EXERCISE);
    }
  }

  static void validateWeightLift(WeightLift exercise) {
    List<LiftSet> sets = exercise.sets;

    if (sets.length <= 0) {
      throw FormatException(NO_EXERCISE_SETS);
    } else if (sets.length > Constants.maxExerciseSets) {
      throw FormatException(TOO_MANY_SETS);
    }

    for (LiftSet liftSet in sets) {
      validateLiftSet(liftSet);
    }
  }

  static void validateLiftSet(LiftSet liftSet) {
    if (liftSet.targetReps < 0 || liftSet.weight < 0 || liftSet.rest < 0) {
      throw FormatException(NEGATIVE_EXERCISE_STAT);
    } else if (liftSet.targetReps > Constants.maxExerciseReps) {
      throw FormatException(TOO_MANY_REPS);
    } else if (liftSet.weight > Constants.maxExerciseWeight) {
      throw FormatException(TOO_MUCH_WEIGHT);
    } else if (liftSet.rest > Constants.maxExerciseRest) {
      throw FormatException(TOO_MUCH_REST);
    } else if (liftSet.reps > liftSet.targetReps) {
      throw FormatException(TARGET_REPS_EXCEEDED);
    }
  }

  static void validateDistanceCardio(DistanceCardio exercise) {
    if (exercise.distance < 0 || exercise.speed < 0) {
      throw FormatException(NEGATIVE_EXERCISE_STAT);
    } else if (exercise.distance > Constants.maxExerciseDistance) {
      throw FormatException(TOO_MUCH_DISTANCE);
    } else if (exercise.speed > Constants.maxExerciseSpeed) {
      throw FormatException(TOO_MUCH_SPEED);
    }
  }

  static void validateTimedCardio(TimedCardio exercise) {
    if (exercise.time < 0 || exercise.speed < 0) {
      throw FormatException(NEGATIVE_EXERCISE_STAT);
    } else if (exercise.time > Constants.maxExerciseTime) {
      throw FormatException(TOO_MUCH_TIME);
    } else if (exercise.speed > Constants.maxExerciseSpeed) {
      throw FormatException(TOO_MUCH_SPEED);
    }
  }
}
