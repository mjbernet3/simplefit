import 'dart:async';
import 'package:client/models/exercise/exercise.dart';
import 'package:client/view_models/view_model.dart';

class ExerciseBrowseModel extends ViewModel {
  List<Exercise> _exercises = [];

  final StreamController<List<Exercise>> _exerciseController =
      StreamController<List<Exercise>>();

  Stream<List<Exercise>> get exerciseStream => _exerciseController.stream;

  void addExercise(Exercise exercise) {
    _exercises.add(exercise);

    _exerciseController.sink.add(_exercises);
  }

  void removeExercise(Exercise exercise) {
    _exercises.remove(exercise);

    _exerciseController.sink.add(_exercises);
  }

  @override
  void dispose() {
    _exerciseController.close();
  }
}
