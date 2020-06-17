class LiftSet {
  final bool isWarmUp;
  final int reps;
  final int weight;

  LiftSet({
    this.isWarmUp,
    this.reps,
    this.weight,
  });

  Map<String, dynamic> toJson() {
    return {
      'isWarmUp': isWarmUp,
      'reps': reps,
      'weight': weight,
    };
  }
}
