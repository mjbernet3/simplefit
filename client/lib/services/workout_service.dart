import 'package:client/models/user/user_data.dart';
import 'package:client/models/workout/workout.dart';
import 'package:client/models/workout/workout_preview.dart';
import 'package:client/utils/validator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class WorkoutService {
  final CollectionReference _workoutCollection;
  final DocumentReference _userRef;

  WorkoutService(_userId)
      : _workoutCollection =
            Firestore.instance.collection('users/$_userId/workouts'),
        _userRef = Firestore.instance.collection('users').document(_userId);

  Future<void> createWorkout(Workout workout) async {
    Validator.validateWorkout(workout);

    final DocumentReference workoutRef = _workoutCollection.document();

    WriteBatch batch = Firestore.instance.batch();
    batch.setData(workoutRef, workout.toJson());

    WorkoutPreview preview = WorkoutPreview(
      id: workoutRef.documentID,
      name: workout.name,
    );

    batch.updateData(_userRef, {
      'previews': FieldValue.arrayUnion([preview.toJson()])
    });

    await batch.commit();
  }

  Future<Workout> getWorkout(String workoutId) async {
    DocumentSnapshot workoutSnap =
        await _workoutCollection.document(workoutId).get();

    Workout workout = Workout.fromSnapshot(workoutSnap);
    return workout;
  }

  Future<void> updateWorkout(String workoutId, Workout workout) async {
    Validator.validateWorkout(workout);

    final DocumentReference workoutRef = _workoutCollection.document(workoutId);
    final DocumentSnapshot userSnap = await _userRef.get();
    final UserData userData = UserData.fromJson(userSnap.data);
    List<WorkoutPreview> previews = userData.previews;

    WriteBatch batch = Firestore.instance.batch();
    batch.updateData(workoutRef, workout.toJson());

    int index = previews.indexWhere((prev) => prev.id == workoutId);

    String oldName = previews[index].name;
    String newName = workout.name;
    if (oldName != newName) {
      previews[index].name = newName;

      List<dynamic> workoutList =
          previews.map((prev) => prev.toJson()).toList();
      batch.updateData(_userRef, {
        'previews': workoutList,
      });
    }

    await batch.commit();
  }

  Future<void> removeWorkout(WorkoutPreview preview) async {
    final DocumentReference workoutRef =
        _workoutCollection.document(preview.id);

    WriteBatch batch = Firestore.instance.batch();
    batch.delete(workoutRef);

    batch.updateData(_userRef, {
      'previews': FieldValue.arrayRemove([preview.toJson()])
    });

    await batch.commit();
  }
}
