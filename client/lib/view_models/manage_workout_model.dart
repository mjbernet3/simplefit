import 'dart:async';
import 'package:client/models/exercise/exercise.dart';
import 'package:client/models/exercise/exercise_data.dart';
import 'package:client/view_models/view_model.dart';

class ManageWorkoutModel extends ViewModel {
  List<ExerciseData> _exercises = [];

  final StreamController<List<ExerciseData>> _exerciseController =
      StreamController<List<ExerciseData>>();

  Stream<List<ExerciseData>> get exerciseStream => _exerciseController.stream;

  List<ExerciseData> getExercises() {
    return _exercises;
  }

  void setExercises(List<ExerciseData> exercises) {
    _exercises = exercises;

    _exerciseController.sink.add(_exercises);
  }

  void initExercises(List<Exercise> exercises) {
    for (Exercise exercise in exercises) {
      ExerciseData newExerciseData = ExerciseData.initial(exercise);

      _exercises.add(newExerciseData);
    }

    _exerciseController.sink.add(_exercises);
  }

  void updateExerciseAt(int index, ExerciseData newExerciseData) {
    _exercises[index] = newExerciseData;

    _exerciseController.sink.add(_exercises);
  }

  void removeExerciseAt(int index) {
    _exercises.removeAt(index);

    _exerciseController.sink.add(_exercises);
  }

  @override
  void dispose() {
    _exerciseController.close();
  }
}
