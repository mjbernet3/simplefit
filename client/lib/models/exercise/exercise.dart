import 'package:cloud_firestore/cloud_firestore.dart';

class Exercise {
  final String id;
  String name;
  String type;
  String bodyPart;

  Exercise({
    this.id,
    this.name,
    this.type,
    this.bodyPart,
  });

  factory Exercise.initial() {
    return Exercise(
      name: '',
      type: '',
      bodyPart: '',
    );
  }

  factory Exercise.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> json = snapshot.data;

    return Exercise(
      id: snapshot.documentID,
      name: json['name'],
      type: json['type'],
      bodyPart: json['bodyPart'],
    );
  }

  factory Exercise.fromJson(Map<String, dynamic> json) {
    return Exercise(
      name: json['name'],
      type: json['type'],
      bodyPart: json['bodyPart'],
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

  Exercise clone() {
    return Exercise(
      id: id,
      name: name,
      type: type,
      bodyPart: bodyPart,
    );
  }
}
