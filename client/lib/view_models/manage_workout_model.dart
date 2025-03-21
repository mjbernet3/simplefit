import 'dart:async';
import 'package:client/models/exercise/exercise.dart';
import 'package:client/models/exercise/exercise_data.dart';
import 'package:client/models/workout/workout.dart';
import 'package:client/services/workout_service.dart';
import 'package:client/view_models/view_model.dart';
import 'package:flutter/material.dart';

class ManageWorkoutModel extends ViewModel {
  late Workout _workout;
  late WorkoutService _workoutService;
  late bool _isEditMode;
  late TextEditingController _nameController;
  late TextEditingController _notesController;

  ManageWorkoutModel({required WorkoutService workoutService, Workout? workout}) {
    _nameController = TextEditingController();
    _notesController = TextEditingController();
    _workoutService = workoutService;
    _isEditMode = (workout != null);
    _initWorkout(workout);
  }

  final StreamController<List<ExerciseData>> _exercisesController =
      StreamController<List<ExerciseData>>();

  final StreamController<bool> _editingController = StreamController<bool>();

  bool get isEditMode => _isEditMode;

  Stream<List<ExerciseData>> get exercises => _exercisesController.stream;

  Stream<bool> get isEditing => _editingController.stream;

  TextEditingController get nameController => _nameController;

  TextEditingController get notesController => _notesController;

  void setEditing(bool value) {
    _editingController.sink.add(value);
  }

  void _initWorkout(Workout? workout) {
    if (_isEditMode) {
      // No need to clone since full workout is fetched on each edit
      _workout = workout!;
    } else {
      _workout = Workout.initial();
    }

    _nameController.text = _workout.name;
    _notesController.text = _workout.notes;
    _exercisesController.sink.add(_workout.exercises);
  }

  void initExercises(List<Exercise> exercises) {
    for (Exercise exercise in exercises) {
      ExerciseData newExercise = ExerciseData.initial(exercise);

      _workout.exercises.add(newExercise);
    }

    _exercisesController.sink.add(_workout.exercises);
  }

  void updateExerciseAt(int index, ExerciseData newExercise) {
    _workout.exercises[index] = newExercise;

    _exercisesController.sink.add(_workout.exercises);
  }

  void removeExerciseAt(int index) {
    _workout.exercises.removeAt(index);

    _exercisesController.sink.add(_workout.exercises);
  }

  void saveWorkout() {
    String name = _nameController.text;
    String notes = _notesController.text;

    if (name.isEmpty) {
      name = 'My Workout';
    }

    _workout.name = name;
    _workout.notes = notes;

    try {
      if (!_isEditMode) {
        _workoutService.createWorkout(_workout);
      } else {
        // Checking if update is needed beforehand is too tedious in this case
        _workoutService.updateWorkout(_workout);
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _notesController.dispose();
    _exercisesController.close();
    _editingController.close();
  }
}
