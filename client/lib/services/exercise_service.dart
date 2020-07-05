import 'package:client/utils/structures/response.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:client/models/exercise/exercise.dart';

class ExerciseService {
  final CollectionReference _exerciseCollection;
  final String _userId;

  ExerciseService(this._userId)
      : _exerciseCollection =
            Firestore.instance.collection('users/$_userId/exercises');

  Stream<List<Exercise>> get exercises {
    return _exerciseCollection.snapshots().map((QuerySnapshot query) => query
        .documents
        .map((DocumentSnapshot snapshot) => Exercise.fromSnapshot(snapshot))
        .toList());
  }

  Future<Response> createExercise(Exercise exercise) async {
    try {
      await _exerciseCollection.add(exercise.toJson());

      return Response(status: Status.SUCCESS);
    } catch (error) {
      return Response(status: Status.FAILURE, message: error.toString());
    }
  }

  Future<Response> editExercise(String exerciseId, Exercise exercise) async {
    try {
      await _exerciseCollection
          .document(exerciseId)
          .updateData(exercise.toJson());

      return Response(status: Status.SUCCESS);
    } catch (error) {
      return Response(status: Status.FAILURE, message: error.toString());
    }
  }

  Future<Response> removeExercise(String exerciseId) async {
    try {
      await _exerciseCollection.document(exerciseId).delete();

      return Response(status: Status.SUCCESS);
    } catch (error) {
      return Response(status: Status.FAILURE, message: error.toString());
    }
  }
}
