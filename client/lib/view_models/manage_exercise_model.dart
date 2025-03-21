import 'dart:async';
import 'package:client/models/exercise/exercise.dart';
import 'package:client/services/exercise_service.dart';
import 'package:client/view_models/view_model.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class ManageExerciseModel extends ViewModel {
  late ExerciseService _exerciseService;
  late Exercise? _prevExercise;
  late Exercise _exercise;
  late bool _isEditMode;
  late TextEditingController _nameController;
  late GlobalKey<FormState> _formKey;

  ManageExerciseModel({required ExerciseService exerciseService, Exercise? exercise}) {
    _nameController = TextEditingController();
    _formKey = GlobalKey<FormState>();
    _exerciseService = exerciseService;
    _isEditMode = (exercise != null);
    _prevExercise = exercise;
    _initExercise();
  }

  final StreamController<Exercise> _exerciseController =
      BehaviorSubject<Exercise>();

  final StreamController<bool> _autovalidateController =
      StreamController<bool>();

  Stream<Exercise> get exercise => _exerciseController.stream;

  Stream<bool> get autovalidate => _autovalidateController.stream;

  TextEditingController get nameController => _nameController;

  GlobalKey<FormState> get formKey => _formKey;

  bool get isEditMode => _isEditMode;

  void setExerciseType(String type) {
    _exercise.type = type;
    _exercise.bodyPart = "";

    _exerciseController.sink.add(_exercise);
  }

  void _initExercise() {
    if (_isEditMode) {
      // Clone exercise so changes can be compared and reverted
      _exercise = _prevExercise!.clone();
    } else {
      _exercise = Exercise.initial();
    }

    _nameController.text = _exercise.name;
    _exerciseController.sink.add(_exercise);
  }

  bool saveExercise() {
    if (_formKey.currentState!.validate()) {
      String name = _nameController.text;
      if (name.isEmpty) {
        name = 'My Exercise';
      }

      _exercise.name = name;

      try {
        if (!_isEditMode) {
          _exerciseService.createExercise(_exercise);
        } else {
          if (!_exercise.equals(_prevExercise!)) {
            _exerciseService.updateExercise(_exercise);
          }
        }
      } catch (e) {
        rethrow;
      }

      return true;
    } else {
      _autovalidateController.sink.add(true);
      return false;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _exerciseController.close();
    _autovalidateController.close();
  }
}
