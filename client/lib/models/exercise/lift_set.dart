class LiftSet {
  bool isWarmUp;
  int reps;
  int weight;
  int rest;

  LiftSet({
    this.isWarmUp,
    this.reps,
    this.weight,
    this.rest,
  });

  factory LiftSet.fromJson(Map<String, dynamic> setData) {
    return LiftSet(
      isWarmUp: setData['isWarmUp'],
      reps: setData['reps'],
      weight: setData['weight'],
      rest: setData['rest'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'isWarmUp': isWarmUp,
      'reps': reps,
      'weight': weight,
      'rest': rest,
    };
  }
}