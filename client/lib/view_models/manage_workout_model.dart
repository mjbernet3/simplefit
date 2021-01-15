import 'dart:async';
import 'package:client/models/exercise/exercise.dart';
import 'package:client/models/exercise/exercise_data.dart';
import 'package:client/models/workout/workout.dart';
import 'package:client/services/workout_service.dart';
import 'package:client/view_models/view_model.dart';

class ManageWorkoutModel extends ViewModel {
  Workout _workout;
  WorkoutService _workoutService;
  bool _isEditMode;

  ManageWorkoutModel({String workoutId, WorkoutService workoutService}) {
    _workoutService = workoutService;
    _isEditMode = (workoutId != null);
    getWorkout(workoutId);
  }

  final StreamController<Workout> _workoutController =
      StreamController<Workout>();

  final StreamController<List<ExerciseData>> _exercisesController =
      StreamController<List<ExerciseData>>();

  final StreamController<bool> _loadingController = StreamController<bool>();

  final StreamController<bool> _editingController = StreamController<bool>();

  bool get isEditMode => _isEditMode;

  Stream<Workout> get workoutStream => _workoutController.stream;

  Stream<List<ExerciseData>> get exerciseStream => _exercisesController.stream;

  Stream<bool> get isLoading => _loadingController.stream;

  Stream<bool> get isEditing => _editingController.stream;

  void setEditing(bool value) {
    _editingController.sink.add(value);
  }

  Future<void> getWorkout(String workoutId) async {
    if (_isEditMode) {
      try {
        _workout = await _workoutService.getWorkout(workoutId);
      } catch (e) {
        _workoutController.sink.addError(e);
        return;
      }
    } else {
      _workout = Workout.initial();
    }

    _exercisesController.sink.add(_workout.exercises);
    _workoutController.sink.add(_workout);
  }

  void initExercises(List<Exercise> exercises) {
    for (Exercise exercise in exercises) {
      ExerciseData newExerciseData = ExerciseData.initial(exercise);

      _workout.exercises.add(newExerciseData);
    }

    _exercisesController.sink.add(_workout.exercises);
  }

  void updateExerciseAt(int index, ExerciseData newExerciseData) {
    _workout.exercises[index] = newExerciseData;

    _exercisesController.sink.add(_workout.exercises);
  }

  void removeExerciseAt(int index) {
    _workout.exercises.removeAt(index);

    _exercisesController.sink.add(_workout.exercises);
  }

  Future<void> saveWorkout(String name, String notes) async {
    _loadingController.sink.add(true);

    if (name.isEmpty) {
      name = 'My Workout';
    }

    _workout.name = name;
    _workout.notes = notes;

    try {
      if (!_isEditMode) {
        await _workoutService.createWorkout(_workout);
      } else {
        await _workoutService.updateWorkout(_workout.id, _workout);
      }
    } catch (e) {
      _loadingController.sink.add(false);
      rethrow;
    }

    _loadingController.sink.add(false);
  }

  @override
  void dispose() {
    _workoutController.close();
    _exercisesController.close();
    _loadingController.close();
    _editingController.close();
  }
}
