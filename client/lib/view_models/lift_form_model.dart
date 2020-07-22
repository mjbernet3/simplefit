import 'package:client/models/exercise/lift_set.dart';
import 'package:client/models/exercise/weight_lift.dart';
import 'package:flutter/material.dart';

class LiftFormModel extends ChangeNotifier {
  WeightLift liftData;

  // Used as temporary info holders so that changes can be reverted
  List<LiftSet> newSets;
  bool isWarmUp;

  LiftFormModel(WeightLift liftData) {
    this.liftData = liftData;

    isWarmUp = liftData.isWarmUp;

    if (liftData.sets.isEmpty) {
      newSets = [LiftSet.initial()];
    } else {
      newSets = liftData.sets.map((LiftSet set) => LiftSet.copy(set)).toList();
    }
  }

  void addSet() {
    newSets.add(LiftSet.initial());

    notifyListeners();
  }

  void removeSet(int index) {
    newSets.removeAt(index);

    notifyListeners();
  }
}
