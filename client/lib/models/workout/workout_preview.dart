class WorkoutPreview {
  final String id;
  String name;

  WorkoutPreview({
    this.id,
    this.name,
  });

  factory WorkoutPreview.fromJson(Map<String, dynamic> workoutData) {
    return WorkoutPreview(
      id: workoutData['id'],
      name: workoutData['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
