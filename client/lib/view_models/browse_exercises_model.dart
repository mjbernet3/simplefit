import 'dart:async';
import 'package:client/models/exercise/exercise.dart';
import 'package:client/view_models/view_model.dart';

class BrowseExercisesModel extends ViewModel {
  List<Exercise> _exercises = [];

  final StreamController<int> _exerciseCountController =
      StreamController<int>();

  Stream<int> get exerciseCountStream => _exerciseCountController.stream;

  List<Exercise> getExercises() {
    return _exercises;
  }

  void addExercise(Exercise exercise) {
    _exercises.add(exercise);

    _exerciseCountController.sink.add(_exercises.length);
  }

  void removeExercise(Exercise exercise) {
    _exercises.remove(exercise);

    _exerciseCountController.sink.add(_exercises.length);
  }

  @override
  void dispose() {
    _exerciseCountController.close();
  }
}
