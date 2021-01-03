import 'dart:async';
import 'package:client/models/exercise/exercise_data.dart';
import 'package:client/models/workout/workout.dart';
import 'package:client/services/workout_service.dart';
import 'package:client/view_models/view_model.dart';

class ProgressModel extends ViewModel {
  WorkoutService _workoutService;
  Workout _workout;
  int _index;

  ProgressModel({WorkoutService workoutService, Workout workout}) {
    _workoutService = workoutService;
    _workout = workout;
    _index = 0;

    _exerciseController.sink.add(_workout.exercises[0]);
  }

  final StreamController<ExerciseData> _exerciseController =
      StreamController<ExerciseData>();

  Stream<ExerciseData> get exerciseStream => _exerciseController.stream;

  bool hasPrevious() {
    return (_index - 1) >= 0;
  }

  void previous() {
    _index--;

    _exerciseController.sink.add(_workout.exercises[_index]);
  }

  String peekNext() {
    return _workout.exercises[_index + 1].exercise.name;
  }

  bool hasNext() {
    return (_index + 1) < _workout.exercises.length;
  }

  void next() {
    _index++;

    _exerciseController.sink.add(_workout.exercises[_index]);
  }

  @override
  void dispose() {
    _exerciseController.close();
  }
}
