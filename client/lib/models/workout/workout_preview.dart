class WorkoutPreview {
  final String id;
  String name;

  WorkoutPreview({
    this.id,
    this.name,
  });

  factory WorkoutPreview.fromJson(Map<String, dynamic> json) {
    return WorkoutPreview(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
