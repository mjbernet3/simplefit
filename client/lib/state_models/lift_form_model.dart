import 'package:client/models/exercise/lift_set.dart';
import 'package:client/models/exercise/weight_lift.dart';
import 'package:flutter/material.dart';

class LiftFormModel extends ChangeNotifier {
  WeightLift liftData;
  List<LiftSet> sets;

  LiftFormModel(WeightLift liftData) {
    this.liftData = liftData;

    if (liftData.sets.isEmpty) {
      sets = [LiftSet.initial()];
    } else {
      sets = liftData.sets;
    }
  }

  void addSet() {
    sets.add(LiftSet.initial());

    notifyListeners();
  }

  void removeSet(int index) {
    print('removing');
  }
}
