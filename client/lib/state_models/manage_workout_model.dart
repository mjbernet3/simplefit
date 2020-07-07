import 'package:client/components/manage_workout/exercise_form.dart';
import 'package:client/models/exercise/exercise.dart';
import 'package:flutter/material.dart';

class ManageWorkoutModel extends ChangeNotifier {
  List<ExerciseForm> _exerciseForms = [];

  List<ExerciseForm> get exerciseForms => _exerciseForms;

  void addExercises(List<Exercise> exercises) {
    for (Exercise exercise in exercises) {
      _exerciseForms.add(ExerciseForm(exercise: exercise));
    }

    notifyListeners();
  }
}
