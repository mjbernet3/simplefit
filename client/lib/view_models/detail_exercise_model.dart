import 'package:client/models/exercise/exercise_data.dart';
import 'package:client/view_models/view_model.dart';
import 'package:flutter/material.dart';

class DetailExerciseModel extends ViewModel {
  ExerciseData _exercise;
  TextEditingController _notesController;

  DetailExerciseModel({ExerciseData exercise}) {
    _notesController = TextEditingController();

    // Clone exercise data so changes can be reverted
    _exercise = exercise.clone();
    _notesController.text = _exercise.notes;
  }

  ExerciseData get exercise => _exercise;

  TextEditingController get notesController => _notesController;

  @override
  void dispose() {
    _notesController.dispose();
  }
}
