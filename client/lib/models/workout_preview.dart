class WorkoutPreview {
  final String id;
  final String name;
  final String description;

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
