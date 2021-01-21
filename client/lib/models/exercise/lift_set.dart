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

  factory LiftSet.fromJson(Map<String, dynamic> json) {
    return LiftSet(
      reps: json['reps'],
      targetReps: json['targetReps'],
      weight: json['weight'],
      rest: json['rest'],
      isWarmUp: json['isWarmUp'],
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

  LiftSet clone() {
    return LiftSet(
      reps: reps,
      targetReps: targetReps,
      weight: weight,
      rest: rest,
      isWarmUp: isWarmUp,
    );
  }
}
