import 'package:client/models/user/user_data.dart';
import 'package:client/models/workout/workout.dart';
import 'package:client/models/workout/workout_preview.dart';
import 'package:client/utils/structures/response.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class WorkoutService {
  final CollectionReference _workoutCollection;
  final DocumentReference _userRef;

  WorkoutService(_userId)
      : _workoutCollection =
            Firestore.instance.collection('users/$_userId/workouts'),
        _userRef = Firestore.instance.collection('users').document(_userId);

  Future<Response> createWorkout(Workout workout) async {
    try {
      final DocumentReference workoutRef = _workoutCollection.document();

      WriteBatch batch = Firestore.instance.batch();
      batch.setData(workoutRef, workout.toJson());

      WorkoutPreview preview = WorkoutPreview(
        id: workoutRef.documentID,
        name: workout.name,
      );

      batch.updateData(_userRef, {
        'workouts': FieldValue.arrayUnion([preview.toJson()])
      });

      await batch.commit();

      return Response(status: Status.SUCCESS);
    } catch (error) {
      return Response(status: Status.FAILURE, message: error.toString());
    }
  }

  Future<Response> getWorkout(String workoutId) async {
    try {
      DocumentSnapshot workoutSnap =
          await _workoutCollection.document(workoutId).get();

      Workout workout = Workout.fromSnapshot(workoutSnap);

      return Response(status: Status.SUCCESS, data: workout);
    } catch (error) {
      return Response(status: Status.FAILURE, message: error.toString());
    }
  }

  Future<Response> updateWorkout(Workout workout) async {
    try {
      final DocumentReference workoutRef =
          _workoutCollection.document(workout.id);
      final DocumentSnapshot userSnap = await _userRef.get();
      final UserData userData = UserData.fromJson(userSnap.data);
      List<WorkoutPreview> previews = userData.workouts;

      WriteBatch batch = Firestore.instance.batch();
      batch.updateData(workoutRef, workout.toJson());

      int index = previews.indexWhere((prev) => prev.id == workout.id);

      String oldName = previews[index].name;
      String newName = workout.name;
      if (oldName != newName) {
        previews[index].name = newName;

        List<dynamic> workoutList =
            previews.map((prev) => prev.toJson()).toList();
        batch.updateData(_userRef, {
          'workouts': workoutList,
        });
      }

      await batch.commit();

      return Response(status: Status.SUCCESS);
    } catch (error) {
      return Response(status: Status.FAILURE, message: error.toString());
    }
  }

  Future<Response> removeWorkout(WorkoutPreview preview) async {
    try {
      final DocumentReference workoutRef =
          _workoutCollection.document(preview.id);

      WriteBatch batch = Firestore.instance.batch();
      batch.delete(workoutRef);

      batch.updateData(_userRef, {
        'workouts': FieldValue.arrayRemove([preview.toJson()])
      });

      await batch.commit();

      return Response(status: Status.SUCCESS);
    } catch (error) {
      return Response(status: Status.FAILURE, message: error.toString());
    }
  }
}
