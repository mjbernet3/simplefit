import 'dart:async';
import 'package:client/models/exercise/exercise_data.dart';
import 'package:client/models/workout/workout.dart';
import 'package:client/services/workout_service.dart';
import 'package:client/utils/structures/response.dart';
import 'package:client/view_models/view_model.dart';

class ProgressModel extends ViewModel {
  WorkoutService _workoutService;
  Workout _workout;
  int _index;

  ProgressModel({WorkoutService workoutService})
      : _workoutService = workoutService;

  final StreamController<ExerciseData> _exerciseController =
      StreamController<ExerciseData>();

  Stream<ExerciseData> get exerciseStream => _exerciseController.stream;

  Future<Response> initWorkout(String workoutId) async {
    Response response = await _workoutService.getWorkout(workoutId);

    if (response.status == Status.SUCCESS) {
      Workout workout = response.data;

      _workout = workout;
      _index = 0;

      _exerciseController.sink.add(_workout.exercises[0]);
    }

    return response;
  }

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

  String get workoutNotes => _workout.notes;

  void setWorkoutNotes(String notes) {
    _workout.notes = notes;
  }

  @override
  void dispose() {
    _exerciseController.close();
  }
}
