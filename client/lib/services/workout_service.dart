import 'package:client/models/user/user_data.dart';
import 'package:client/models/workout/workout.dart';
import 'package:client/models/workout/workout_preview.dart';
import 'package:client/utils/validator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class WorkoutService {
  final CollectionReference _workoutCollection;
  final DocumentReference _userReference;

  WorkoutService(_userId)
      : _workoutCollection =
            Firestore.instance.collection('users/$_userId/workouts'),
        _userReference =
            Firestore.instance.collection('users').document(_userId);

  Future<void> createWorkout(Workout workout) async {
    Validator.validateWorkout(workout);

    DocumentReference workoutReference = _workoutCollection.document();

    WriteBatch batch = Firestore.instance.batch();

    batch.setData(workoutReference, workout.toJson());

    WorkoutPreview preview = WorkoutPreview(
      id: workoutReference.documentID,
      name: workout.name,
    );

    batch.updateData(_userReference, {
      'previews': FieldValue.arrayUnion([preview.toJson()])
    });

    await batch.commit();
  }

  Future<Workout> getWorkout(String workoutId) async {
    DocumentSnapshot workoutSnapshot =
        await _workoutCollection.document(workoutId).get();

    Workout workout = Workout.fromSnapshot(workoutSnapshot);
    return workout;
  }

  Future<void> updateWorkout(Workout workout) async {
    Validator.validateWorkout(workout);

    DocumentReference workoutReference =
        _workoutCollection.document(workout.id);
    DocumentSnapshot userSnapshot = await _userReference.get();

    UserData userData = UserData.fromJson(userSnapshot.data);
    List<WorkoutPreview> previews = userData.previews;

    WriteBatch batch = Firestore.instance.batch();

    batch.updateData(workoutReference, workout.toJson());

    int index = previews.indexWhere((preview) => preview.id == workout.id);
    String oldName = previews[index].name;
    String newName = workout.name;

    if (oldName != newName) {
      previews[index].name = newName;

      List<dynamic> previewList =
          previews.map((preview) => preview.toJson()).toList();

      batch.updateData(_userReference, {
        'previews': previewList,
      });
    }

    await batch.commit();
  }

  Future<void> removeWorkout(WorkoutPreview preview) async {
    DocumentReference workoutReference =
        _workoutCollection.document(preview.id);

    WriteBatch batch = Firestore.instance.batch();

    batch.delete(workoutReference);

    batch.updateData(_userReference, {
      'previews': FieldValue.arrayRemove([preview.toJson()])
    });

    await batch.commit();
  }
}
