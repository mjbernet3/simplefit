import 'package:cloud_firestore/cloud_firestore.dart';

class Exercise {
  String id;
  String name;
  String type;
  String bodyPart;

  Exercise({
    this.id,
    this.name,
    this.type,
    this.bodyPart,
  });

  factory Exercise.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> exerciseData = snapshot.data;

    return Exercise(
      id: snapshot.documentID,
      name: exerciseData['name'],
      type: exerciseData['type'],
      bodyPart: exerciseData['bodyPart'],
    );
  }

  factory Exercise.fromJson(Map<String, dynamic> exerciseData) {
    return Exercise(
      name: exerciseData['name'],
      type: exerciseData['type'],
      bodyPart: exerciseData['bodyPart'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'type': type,
      'bodyPart': bodyPart,
    };
  }

  bool equals(Exercise other) {
    if (name == other.name &&
        type == other.type &&
        bodyPart == other.bodyPart) {
      return true;
    }

    return false;
  }
}
