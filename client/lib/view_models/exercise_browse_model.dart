import 'package:client/models/exercise/exercise.dart';
import 'package:flutter/material.dart';

class ExerciseBrowseModel extends ChangeNotifier {
  List<Exercise> _exercises = [];

  List<Exercise> get exercises => _exercises;

  void addExercise(Exercise exercise) {
    _exercises.add(exercise);
    notifyListeners();
  }

  void removeExercise(Exercise exercise) {
    _exercises.remove(exercise);
    notifyListeners();
  }
}
