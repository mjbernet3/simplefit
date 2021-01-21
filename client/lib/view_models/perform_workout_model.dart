import 'dart:async';
import 'package:client/models/exercise/exercise_data.dart';
import 'package:client/models/workout/workout.dart';
import 'package:client/services/workout_service.dart';
import 'package:client/view_models/view_model.dart';

class PerformWorkoutModel extends ViewModel {
  WorkoutService _workoutService;
  Workout _workout;
  int _currentIndex;
  bool _isResting;

  PerformWorkoutModel({WorkoutService workoutService, Workout workout}) {
    _workoutService = workoutService;
    _workout = workout;
    _currentIndex = 0;
    _isResting = false;

    _exerciseController.sink.add(_workout.exercises[0]);
  }

  final StreamController<ExerciseData> _exerciseController =
      StreamController<ExerciseData>();

  final StreamController<bool> _loadingController = StreamController<bool>();

  final StreamController<bool> _restingController = StreamController<bool>();

  Stream<ExerciseData> get exerciseStream => _exerciseController.stream;

  Stream<bool> get isLoading => _loadingController.stream;

  Stream<bool> get isResting => _restingController.stream;

  bool hasPrevious() {
    return (_currentIndex - 1) >= 0;
  }

  void previous() {
    if (_isResting) {
      _isResting = false;
      _restingController.sink.add(_isResting);
    } else {
      _currentIndex--;
      _exerciseController.sink.add(_workout.exercises[_currentIndex]);
    }
  }

  String peekNext() {
    return _workout.exercises[_currentIndex + 1].exercise.name;
  }

  bool hasNext() {
    return (_currentIndex + 1) < _workout.exercises.length;
  }

  void next() {
    ExerciseData currentExercise = _workout.exercises[_currentIndex];

    if (!_isResting && currentExercise.rest > 0) {
      _isResting = true;
      _restingController.sink.add(_isResting);
    } else {
      _currentIndex++;
      _exerciseController.sink.add(_workout.exercises[_currentIndex]);

      _isResting = false;
      _restingController.sink.add(_isResting);
    }
  }

  Future<void> finishWorkout() async {
    _loadingController.sink.add(true);

    try {
      await _workoutService.updateWorkout(_workout);
    } catch (e) {
      _loadingController.sink.add(false);
      rethrow;
    }

    _loadingController.sink.add(false);
  }

  @override
  void dispose() {
    _exerciseController.close();
    _loadingController.close();
    _restingController.close();
  }
}
