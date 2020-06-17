class LiftSet {
  final bool isWarmUp;
  final int reps;
  final int weight;

  LiftSet({
    this.isWarmUp,
    this.reps,
    this.weight,
  });

  factory LiftSet.fromJson(Map<String, dynamic> setData) {
    return LiftSet(
      isWarmUp: setData['isWarmUp'],
      reps: setData['reps'],
      weight: setData['weight'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'isWarmUp': isWarmUp,
      'reps': reps,
      'weight': weight,
    };
  }
}
