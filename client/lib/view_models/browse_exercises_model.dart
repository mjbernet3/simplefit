import 'dart:async';
import 'package:client/models/exercise/exercise.dart';
import 'package:client/view_models/view_model.dart';
import 'package:rxdart/rxdart.dart';

class BrowseExercisesModel extends ViewModel {
  List<Exercise> _chosenExercises = [];

  final StreamController<List<Exercise>> _chosenExercisesController =
      StreamController<List<Exercise>>();

  final StreamController<bool> _editingController = BehaviorSubject<bool>();

  Stream<List<Exercise>> get chosenExercises =>
      _chosenExercisesController.stream;

  Stream<bool> get isEditing => _editingController.stream;

  void setEditing(bool value) {
    _editingController.sink.add(value);
  }

  void addExercise(Exercise exercise) {
    _chosenExercises.add(exercise);

    _chosenExercisesController.sink.add(_chosenExercises);
  }

  void removeExercise(Exercise exercise) {
    _chosenExercises
        .removeWhere((chosenExercise) => exercise.equals(chosenExercise));

    _chosenExercisesController.sink.add(_chosenExercises);
  }

  @override
  void dispose() {
    _chosenExercisesController.close();
    _editingController.close();
  }
}
