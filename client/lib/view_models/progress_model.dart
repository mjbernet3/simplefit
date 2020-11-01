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
      _index = -1;
    }

    return response;
  }

  String getNotes() {
    if (_index >= 0) {
      return _workout.exercises[_index].notes;
    }

    return _workout.notes;
  }

  void setNotes(String notes) {
    if (_index >= 0) {
      _workout.exercises[_index].notes = notes;
    } else {
      _workout.notes = notes;
    }
  }

  @override
  void dispose() {
    _exerciseController.close();
  }
}
