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

  Future<void> createExercise(Exercise exercise) async {
    Validator.validateExercise(exercise);

    await _exerciseCollection.add(exercise.toJson());
  }

  Future<void> updateExercise(Exercise exercise) async {
    Validator.validateExercise(exercise);

    await _exerciseCollection.doc(exercise.id).update(exercise.toJson());
  }

  Future<void> removeExercise(String exerciseId) async {
    await _exerciseCollection.doc(exerciseId).delete();
  }
}
