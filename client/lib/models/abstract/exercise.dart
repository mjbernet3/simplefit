abstract class Exercise {
  final String name;
  final String type;
  final String notes;
  final int rest;
  final bool isWarmUp;

  Exercise(
    this.name,
    this.type,
    this.notes,
    this.rest,
    this.isWarmUp,
  );

  Map<String, dynamic> toJson();
}
