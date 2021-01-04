import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:client/models/exercise/exercise.dart';

class ExerciseService {
  final CollectionReference _exerciseCollection;

  ExerciseService(_userId)
      : _exerciseCollection =
            Firestore.instance.collection('users/$_userId/exercises');

  Stream<List<Exercise>> get exercises {
    return _exerciseCollection.snapshots().map((QuerySnapshot query) => query
        .documents
        .map((DocumentSnapshot snapshot) => Exercise.fromSnapshot(snapshot))
        .toList());
  }

  Future<void> createExercise(Exercise exercise) async {
    await _exerciseCollection.add(exercise.toJson());
  }

  Future<void> updateExercise(String exerciseId, Exercise exercise) async {
    await _exerciseCollection
        .document(exerciseId)
        .updateData(exercise.toJson());
  }

  Future<void> removeExercise(String exerciseId) async {
    await _exerciseCollection.document(exerciseId).delete();
  }
}
