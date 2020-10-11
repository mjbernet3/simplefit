import 'dart:async';
import 'package:client/models/exercise/exercise_data.dart';
import 'package:client/models/workout/workout.dart';
import 'package:client/services/workout_service.dart';
import 'package:client/utils/structures/response.dart';
import 'package:client/view_models/view_model.dart';

class ProgressModel extends ViewModel {
  WorkoutService _workoutService;
  String _workoutId;
  List<ExerciseData> _exercises;
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

      _workoutId = workout.id;
      _exercises = workout.exercises;
      _index = 0;
      _exerciseController.sink.add(_exercises[_index]);
    }

    return response;
  }

  @override
  void dispose() {
    _exerciseController.close();
  }
}
