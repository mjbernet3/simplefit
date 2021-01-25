import 'package:client/models/user/user_data.dart';
import 'package:client/models/workout/workout.dart';
import 'package:client/models/workout/workout_preview.dart';
import 'package:client/utils/validator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class WorkoutService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final CollectionReference _workoutCollection;
  final DocumentReference _userReference;

  WorkoutService(_userId)
      : _workoutCollection =
            FirebaseFirestore.instance.collection('users/$_userId/workouts'),
        _userReference =
            FirebaseFirestore.instance.collection('users').doc(_userId);

  void createWorkout(Workout workout) {
    Validator.validateWorkout(workout);

    DocumentReference workoutReference = _workoutCollection.doc();

    WriteBatch batch = _firestore.batch();

    batch.set(workoutReference, workout.toJson());

    WorkoutPreview preview = WorkoutPreview(
      id: workoutReference.id,
      name: workout.name,
    );

    batch.update(_userReference, {
      'previews': FieldValue.arrayUnion([preview.toJson()])
    });

    batch.commit();
  }

  Future<Workout> getWorkout(String workoutId) async {
    DocumentSnapshot workoutSnapshot =
        await _workoutCollection.doc(workoutId).get();

    Workout workout = Workout.fromSnapshot(workoutSnapshot);
    return workout;
  }

  void updateWorkout(Workout workout) async {
    Validator.validateWorkout(workout);

    DocumentReference workoutReference = _workoutCollection.doc(workout.id);
    DocumentSnapshot userSnapshot = await _userReference.get();

    UserData userData = UserData.fromJson(userSnapshot.data());
    List<WorkoutPreview> previews = userData.previews;

    WriteBatch batch = _firestore.batch();

    batch.update(workoutReference, workout.toJson());

    int index = previews.indexWhere((preview) => preview.id == workout.id);
    String oldName = previews[index].name;
    String newName = workout.name;

    if (oldName != newName) {
      previews[index].name = newName;

      List<dynamic> previewList =
          previews.map((preview) => preview.toJson()).toList();

      batch.update(_userReference, {
        'previews': previewList,
      });
    }

    batch.commit();
  }

  void removeWorkout(WorkoutPreview preview) {
    DocumentReference workoutReference = _workoutCollection.doc(preview.id);

    WriteBatch batch = _firestore.batch();

    batch.delete(workoutReference);

    batch.update(_userReference, {
      'previews': FieldValue.arrayRemove([preview.toJson()])
    });

    batch.commit();
  }
}
