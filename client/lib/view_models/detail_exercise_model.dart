import 'package:client/models/exercise/exercise_data.dart';
import 'package:client/view_models/view_model.dart';
import 'package:flutter/material.dart';

class DetailExerciseModel extends ViewModel {
  TextEditingController _notesController;
  ExerciseData _exerciseData;

  DetailExerciseModel({ExerciseData exerciseData}) {
    _notesController = TextEditingController();
    _exerciseData = exerciseData.clone();
    _notesController.text = _exerciseData.notes;
  }

  ExerciseData get exerciseData => _exerciseData;

  TextEditingController get notesController => _notesController;

  @override
  void dispose() {
    _notesController.dispose();
  }
}
