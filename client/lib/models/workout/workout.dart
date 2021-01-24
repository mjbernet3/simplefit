import 'package:client/models/exercise/exercise_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Workout {
  final String id;
  String name;
  String notes;
  List<ExerciseData> exercises;

  Workout({
    this.id,
    this.name,
    this.notes,
    this.exercises,
  });

  factory Workout.initial() {
    return Workout(
      name: '',
      notes: '',
      exercises: [],
    );
  }

  factory Workout.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> json = snapshot.data();

    List<dynamic> exerciseList = snapshot.data()['exercises'] as List;
    List<ExerciseData> exercises = exerciseList
        .map((exercise) => ExerciseData.fromJson(exercise))
        .toList();

    return Workout(
      id: snapshot.id,
      name: json['name'],
      notes: json['notes'],
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
