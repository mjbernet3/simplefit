import 'package:client/models/exercise/exercise_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Workout {
  String id;
  String name;
  String notes;
  List<ExerciseData> exercises;

  Workout({
    this.id,
    this.name,
    this.notes,
    this.exercises,
  });

  factory Workout.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> workoutData = snapshot.data;

    List<dynamic> exerciseJson = snapshot.data['exercises'] as List;
    List<ExerciseData> exercises = exerciseJson
        .map((exercise) => ExerciseData.fromJson(exercise))
        .toList();

    return Workout(
      id: snapshot.documentID,
      name: workoutData['name'],
      notes: workoutData['notes'],
      exercises: exercises,
    );
  }

  Map<String, dynamic> toJson() {
    List<dynamic> exerciseList =
        exercises.map((exercise) => exercise.toJson()).toList();

    return {
      'name': name,
      'notes': notes,
      'exercises': exerciseList,
    };
  }
}
