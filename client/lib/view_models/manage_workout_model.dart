import 'dart:async';
import 'package:client/models/exercise/exercise.dart';
import 'package:client/models/exercise/exercise_data.dart';
import 'package:client/models/workout/workout.dart';
import 'package:client/services/workout_service.dart';
import 'package:client/view_models/view_model.dart';

class ManageWorkoutModel extends ViewModel {
  Workout _workout;
  WorkoutService _workoutService;
  bool _isEdit;

  ManageWorkoutModel({String workoutId, WorkoutService workoutService}) {
    _workoutService = workoutService;
    _isEdit = (workoutId != null);
    getWorkout(workoutId);
  }

  final StreamController<Workout> _workoutController =
      StreamController<Workout>();

  final StreamController<List<ExerciseData>> _exerciseController =
      StreamController<List<ExerciseData>>();

  Stream<Workout> get workoutStream => _workoutController.stream;

  Stream<List<ExerciseData>> get exerciseStream => _exerciseController.stream;

  bool get isEdit => _isEdit;

  Future<void> getWorkout(String workoutId) async {
    if (_isEdit) {
      try {
        _workout = await _workoutService.getWorkout(workoutId);
      } catch (e) {
        _workoutController.sink.addError(e);
        return;
      }
    } else {
      _workout = Workout.initial();
    }

    _exerciseController.sink.add(_workout.exercises);
    _workoutController.sink.add(_workout);
  }

  void initExercises(List<Exercise> exercises) {
    for (Exercise exercise in exercises) {
      ExerciseData newExerciseData = ExerciseData.initial(exercise);

      _workout.exercises.add(newExerciseData);
    }

    _exerciseController.sink.add(_workout.exercises);
  }

  void updateExerciseAt(int index, ExerciseData newExerciseData) {
    _workout.exercises[index] = newExerciseData;

    _exerciseController.sink.add(_workout.exercises);
  }

  void removeExerciseAt(int index) {
    _workout.exercises.removeAt(index);

    _exerciseController.sink.add(_workout.exercises);
  }

  Future<void> saveWorkout(String name, String notes) async {
    if (name.isEmpty) {
      name = 'My Workout';
    }

    _workout.name = name;
    _workout.notes = notes;

    try {
      if (!_isEdit) {
        await _workoutService.createWorkout(_workout);
      } else {
        await _workoutService.updateWorkout(_workout.id, _workout);
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  void dispose() {
    _workoutController.close();
    _exerciseController.close();
  }
}
