import 'package:client/models/exercise/lift_set.dart';
import 'package:client/models/exercise/weight_lift.dart';
import 'package:flutter/material.dart';

class LiftFormModel extends ChangeNotifier {
  WeightLift liftData;
  List<LiftSet> newSets;

  LiftFormModel(WeightLift liftData) {
    this.liftData = liftData;

    if (liftData.sets.isEmpty) {
      newSets = [LiftSet.initial()];
    } else {
      // Copy existing sets so that changes can be ignored on cancellation
      newSets = liftData.sets.map((LiftSet set) => LiftSet.copy(set)).toList();
    }
  }

  void addSet() {
    newSets.add(LiftSet.initial());

    notifyListeners();
  }

  void removeSet(int index) {
    print('removing');
  }
}
