import 'dart:async';
import 'package:client/models/exercise/exercise.dart';
import 'package:client/models/exercise/exercise_data.dart';
import 'package:client/models/workout/workout.dart';
import 'package:client/services/workout_service.dart';
import 'package:client/view_models/view_model.dart';
import 'package:flutter/material.dart';

class ManageWorkoutModel extends ViewModel {
  Workout _workout;
  WorkoutService _workoutService;
  bool _isEditMode;
  TextEditingController _nameController;
  TextEditingController _notesController;

  ManageWorkoutModel({Workout workout, WorkoutService workoutService}) {
    _nameController = TextEditingController();
    _notesController = TextEditingController();
    _workoutService = workoutService;
    _isEditMode = (workout != null);
    _initWorkout(workout);
  }

  final StreamController<List<ExerciseData>> _exercisesController =
      StreamController<List<ExerciseData>>();

  final StreamController<bool> _loadingController = StreamController<bool>();

  final StreamController<bool> _editingController = StreamController<bool>();

  bool get isEditMode => _isEditMode;

  Stream<List<ExerciseData>> get exerciseStream => _exercisesController.stream;

  Stream<bool> get isLoading => _loadingController.stream;

  Stream<bool> get isEditing => _editingController.stream;

  TextEditingController get nameController => _nameController;

  TextEditingController get notesController => _notesController;

  void setEditing(bool value) {
    _editingController.sink.add(value);
  }

  void _initWorkout(Workout workout) {
    if (_isEditMode) {
      _workout = workout;
    } else {
      _workout = Workout.initial();
    }

    _nameController.text = _workout.name;
    _notesController.text = _workout.notes;
    _exercisesController.sink.add(_workout.exercises);
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

  Future<void> saveWorkout() async {
    String name = _nameController.text;
    String notes = _notesController.text;

    if (name.isEmpty) {
      name = 'My Workout';
    }

    _workout.name = name;
    _workout.notes = notes;

    _loadingController.sink.add(true);

    try {
      if (!_isEditMode) {
        await _workoutService.createWorkout(_workout);
      } else {
        // Checking if update is needed beforehand is too expensive to be worth it in this case
        await _workoutService.updateWorkout(_workout);
      }
    } catch (e) {
      _loadingController.sink.add(false);
      rethrow;
    }

    _loadingController.sink.add(false);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _notesController.dispose();
    _exercisesController.close();
    _loadingController.close();
    _editingController.close();
  }
}
