import 'dart:async';
import 'package:client/models/exercise/exercise.dart';
import 'package:client/services/exercise_service.dart';
import 'package:client/view_models/view_model.dart';
import 'package:flutter/material.dart';

class ManageExerciseModel extends ViewModel {
  ExerciseService _exerciseService;
  Exercise _prevExercise;
  Exercise _exercise;
  bool _isEditMode;
  TextEditingController _nameController;

  ManageExerciseModel({ExerciseService exerciseService, Exercise exercise}) {
    _nameController = TextEditingController();
    _exerciseService = exerciseService;
    _isEditMode = (exercise != null);
    _prevExercise = exercise;
    _initExercise();
  }

  final StreamController<Exercise> _exerciseController =
      StreamController<Exercise>();

  final StreamController<bool> _loadingController = StreamController<bool>();

  final StreamController<bool> _autovalidateController =
      StreamController<bool>();

  Stream<Exercise> get exerciseStream => _exerciseController.stream;

  Stream<bool> get isLoading => _loadingController.stream;

  Stream<bool> get autovalidate => _autovalidateController.stream;

  TextEditingController get nameController => _nameController;

  bool get isEditMode => _isEditMode;

  void setExerciseType(String type) {
    _exercise.type = type;
    _exercise.bodyPart = null;

    _exerciseController.sink.add(_exercise);
  }

  void setAutovalidate(bool value) {
    _autovalidateController.sink.add(value);
  }

  void _initExercise() {
    if (_isEditMode) {
      _exercise = _prevExercise.clone();
    } else {
      _exercise = Exercise.initial();
    }

    _nameController.text = _exercise.name;
    _exerciseController.sink.add(_exercise);
  }

  Future<void> saveExercise() async {
    String name = _nameController.text;
    if (name.isEmpty) {
      name = 'My Exercise';
    }

    _exercise.name = name;

    _loadingController.sink.add(true);

    try {
      if (!_isEditMode) {
        await _exerciseService.createExercise(_exercise);
      } else {
        if (!_exercise.equals(_prevExercise)) {
          await _exerciseService.updateExercise(_exercise.id, _exercise);
        }
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
    _exerciseController.close();
    _loadingController.close();
    _autovalidateController.close();
  }
}