import 'package:client/models/exercise/exercise.dart';
import 'package:client/models/exercise/exercise_data.dart';
import 'package:flutter/material.dart';

class ManageWorkoutModel extends ChangeNotifier {
  List<ExerciseData> _exercises = [];

  List<ExerciseData> get exercises => _exercises;

  void initExercises(List<Exercise> exercises) {
    for (Exercise exercise in exercises) {
      ExerciseData newExerciseData = ExerciseData.initial(exercise);

      _exercises.add(newExerciseData);
    }

    notifyListeners();
  }

  void removeExerciseAt(int index) {
    _exercises.removeAt(index);

    notifyListeners();
  }
}
