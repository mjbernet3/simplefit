class WorkoutPreview {
  final String id;
  final String name;

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
}
