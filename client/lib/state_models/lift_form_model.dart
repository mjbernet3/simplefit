import 'package:client/models/exercise/lift_set.dart';
import 'package:client/models/exercise/weight_lift.dart';
import 'package:flutter/material.dart';

class LiftFormModel extends ChangeNotifier {
  WeightLift liftData;
  List<LiftSet> sets = [LiftSet.initial()];

  LiftFormModel({this.liftData});

  void addSet() {
    sets.add(LiftSet.initial());

    notifyListeners();
  }

  void removeSet(int index) {
    print('removing');
  }
}
