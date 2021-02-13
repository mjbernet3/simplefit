import 'dart:async';
import 'package:client/models/exercise/exercise_data.dart';
import 'package:client/models/exercise/lift_set.dart';
import 'package:client/models/exercise/weight_lift.dart';
import 'package:client/models/workout/workout.dart';
import 'package:client/services/workout_service.dart';
import 'package:client/view_models/view_model.dart';
import 'package:rxdart/rxdart.dart';

// Replace runtime exercise type checks if alternate method presents itself
class PerformWorkoutModel extends ViewModel {
  WorkoutService _workoutService;
  Workout _workout;
  int _currentIndex;
  int _currentSetIndex;
  bool _isResting;

  PerformWorkoutModel({WorkoutService workoutService, Workout workout}) {
    _workoutService = workoutService;
    _workout = workout;
    _currentIndex = 0;
    _currentSetIndex = 0;
    _isResting = false;

    ExerciseData firstExercise = _workout.exercises[0];
    _exerciseController.sink.add(firstExercise);

    if (firstExercise is WeightLift) {
      _setController.sink.add(firstExercise.sets[0]);
    }
  }

  final StreamController<ExerciseData> _exerciseController =
      StreamController<ExerciseData>();

  final StreamController<LiftSet> _setController = BehaviorSubject<LiftSet>();

  final StreamController<bool> _restingController = StreamController<bool>();

  Stream<ExerciseData> get exercise => _exerciseController.stream;

  Stream<LiftSet> get set => _setController.stream;

  Stream<bool> get isResting => _restingController.stream;

  int get setNumber => _currentSetIndex + 1;

  String getRestTitle() {
    ExerciseData currentExercise = _workout.exercises[_currentIndex];

    if (currentExercise is WeightLift && _hasNextSet(currentExercise)) {
      int setsLeft = currentExercise.sets.length - setNumber;

      return '$setsLeft Set${setsLeft > 1 ? 's' : ''} Remaining';
    }

    return 'Next: ${_workout.exercises[_currentIndex + 1].exercise.name}';
  }

  int getRest() {
    ExerciseData currentExercise = _workout.exercises[_currentIndex];

    if (currentExercise is WeightLift) {
      return currentExercise.sets[_currentSetIndex].rest;
    }

    return currentExercise.rest;
  }

  bool hasPrevious() {
    ExerciseData currentExercise = _workout.exercises[_currentIndex];

    if (currentExercise is WeightLift) {
      return _hasPreviousSet(currentExercise) || _hasPreviousExercise();
    }

    return _hasPreviousExercise();
  }

  bool _hasPreviousSet(WeightLift exercise) {
    return (_currentSetIndex - 1) >= 0;
  }

  bool _hasPreviousExercise() {
    return (_currentIndex - 1) >= 0;
  }

  void previous() {
    ExerciseData currentExercise = _workout.exercises[_currentIndex];

    if (_isResting) {
      _isResting = false;
      _restingController.sink.add(_isResting);
      return;
    }

    if (currentExercise is WeightLift) {
      _previousSet(currentExercise);
    } else {
      _previousExercise();
    }
  }

  void _previousSet(WeightLift exercise) {
    if (!_hasPreviousSet(exercise)) {
      _previousExercise();
    } else {
      _currentSetIndex--;
      _setController.sink.add(exercise.sets[_currentSetIndex]);
    }
  }

  void _previousExercise() {
    _currentIndex--;
    ExerciseData prevExercise = _workout.exercises[_currentIndex];
    _exerciseController.sink.add(prevExercise);

    if (prevExercise is WeightLift) {
      _currentSetIndex = prevExercise.sets.length - 1;
      _setController.sink.add(prevExercise.sets[_currentSetIndex]);
    }
  }

  bool hasNext() {
    ExerciseData currentExercise = _workout.exercises[_currentIndex];

    if (currentExercise is WeightLift) {
      return _hasNextSet(currentExercise) || _hasNextExercise();
    }

    return _hasNextExercise();
  }

  bool _hasNextSet(WeightLift exercise) {
    return _currentSetIndex < (exercise.sets.length - 1);
  }

  bool _hasNextExercise() {
    return _currentIndex < (_workout.exercises.length - 1);
  }

  void next() {
    ExerciseData currentExercise = _workout.exercises[_currentIndex];

    if (currentExercise is WeightLift) {
      _nextSet(currentExercise);
    } else {
      _nextExercise(currentExercise);
    }
  }

  void _nextSet(WeightLift exercise) {
    LiftSet currentSet = exercise.sets[_currentSetIndex];

    if (!_isResting && currentSet.rest > 0) {
      _isResting = true;
      _restingController.sink.add(_isResting);
      return;
    }

    if (!_hasNextSet(exercise)) {
      _nextExercise(exercise);
    } else {
      _currentSetIndex++;
      _setController.sink.add(exercise.sets[_currentSetIndex]);

      _isResting = false;
      _restingController.sink.add(_isResting);
    }
  }

  void _nextExercise(ExerciseData currentExercise) {
    if (!_isResting && currentExercise.rest > 0) {
      _isResting = true;
      _restingController.sink.add(_isResting);
      return;
    }

    _currentIndex++;
    ExerciseData nextExercise = _workout.exercises[_currentIndex];
    _exerciseController.sink.add(nextExercise);

    if (nextExercise is WeightLift) {
      _currentSetIndex = 0;
      _setController.sink.add(nextExercise.sets[0]);
    }

    _isResting = false;
    _restingController.sink.add(_isResting);
  }

  void finishWorkout() {
    try {
      _workoutService.updateWorkout(_workout);
    } catch (e) {
      rethrow;
    }
  }

  @override
  void dispose() {
    _exerciseController.close();
    _setController.close();
    _restingController.close();
  }
}
