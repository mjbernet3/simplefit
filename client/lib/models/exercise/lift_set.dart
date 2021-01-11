class LiftSet {
  int reps;
  int targetReps;
  int weight;
  int rest;
  bool isWarmUp;

  LiftSet({
    this.reps,
    this.targetReps,
    this.weight,
    this.rest,
    this.isWarmUp,
  });

  factory LiftSet.initial() {
    return LiftSet(
      reps: 0,
      targetReps: 0,
      weight: 0,
      rest: 0,
      isWarmUp: false,
    );
  }

  factory LiftSet.fromJson(Map<String, dynamic> setData) {
    return LiftSet(
      reps: setData['reps'],
      targetReps: setData['targetReps'],
      weight: setData['weight'],
      rest: setData['rest'],
      isWarmUp: setData['isWarmUp'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'reps': reps,
      'targetReps': targetReps,
      'weight': weight,
      'rest': rest,
      'isWarmUp': isWarmUp,
    };
  }

  LiftSet copy() {
    return LiftSet(
      reps: reps,
      targetReps: targetReps,
      weight: weight,
      rest: rest,
      isWarmUp: isWarmUp,
    );
  }
}
