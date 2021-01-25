import 'package:client/utils/validator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:client/models/exercise/exercise.dart';

class ExerciseService {
  final CollectionReference _exerciseCollection;

  ExerciseService(_userId)
      : _exerciseCollection =
            FirebaseFirestore.instance.collection('users/$_userId/exercises');

  Stream<List<Exercise>> get exercises => _exerciseCollection
      .orderBy('name')
      .snapshots()
      .map((QuerySnapshot query) => query.docs
          .map((DocumentSnapshot snapshot) => Exercise.fromSnapshot(snapshot))
          .toList());

  void createExercise(Exercise exercise) {
    Validator.validateExercise(exercise);

    _exerciseCollection.add(exercise.toJson());
  }

  void updateExercise(Exercise exercise) {
    Validator.validateExercise(exercise);

    _exerciseCollection.doc(exercise.id).update(exercise.toJson());
  }

  void removeExercise(String exerciseId) {
    _exerciseCollection.doc(exerciseId).delete();
  }
}
