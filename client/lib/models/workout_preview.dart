class WorkoutPreview {
  String id;
  String name;
  String description;

  WorkoutPreview({
    this.id,
    this.name,
    this.description,
  });

  factory WorkoutPreview.fromJson(Map<String, dynamic> workoutData) {
    return WorkoutPreview(
      id: workoutData['id'],
      name: workoutData['name'],
      description: workoutData['description'],
    );
  }
}
