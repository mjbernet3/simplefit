import 'package:client/models/workout/workout.dart';
import 'package:client/utils/structures/response.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class WorkoutService {
  final CollectionReference _workoutCollection;
  final String _userId;

  WorkoutService(this._userId)
      : _workoutCollection =
            Firestore.instance.collection('users/$_userId/workouts');

  Future<Response> createWorkout(Workout workout) async {
    try {
      await _workoutCollection.add(workout.toJson());

      return Response(status: Status.SUCCESS);
    } catch (error) {
      return Response(status: Status.FAILURE, message: error.toString());
    }
  }

  Future<Response> removeWorkout(String workoutId) async {
    try {
      await _workoutCollection.document(workoutId).delete();

      return Response(status: Status.SUCCESS);
    } catch (error) {
      return Response(status: Status.FAILURE, message: error.toString());
    }
  }
}
