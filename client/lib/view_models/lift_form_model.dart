import 'dart:async';
import 'package:client/models/exercise/lift_set.dart';
import 'package:client/models/exercise/weight_lift.dart';
import 'package:client/view_models/view_model.dart';

class LiftFormModel extends ViewModel {
  WeightLift liftData;
  List<LiftSet> workingSets;
  bool isWarmUp;

  final StreamController<List<LiftSet>> _setController =
      StreamController<List<LiftSet>>();
  final StreamController<bool> _warmUpController = StreamController<bool>();

  Stream<List<LiftSet>> get setStream => _setController.stream;
  Stream<bool> get warmUpStream => _warmUpController.stream;

  LiftFormModel(WeightLift liftData) {
    this.liftData = liftData;

    isWarmUp = liftData.isWarmUp;

    if (liftData.sets.isEmpty) {
      workingSets = [LiftSet.initial()];
    } else {
      workingSets =
          liftData.sets.map((LiftSet set) => LiftSet.copy(set)).toList();
    }

    _setController.sink.add(workingSets);
    _warmUpController.sink.add(isWarmUp);
  }

  void addSet() {
    workingSets.add(LiftSet.initial());

    _setController.sink.add(workingSets);
  }

  void removeSet(int index) {
    workingSets.removeAt(index);

    _setController.sink.add(workingSets);
  }

  void toggleWarmUp() {
    isWarmUp = !isWarmUp;

    _warmUpController.sink.add(isWarmUp);
  }

  @override
  void dispose() {
    _setController.close();
    _warmUpController.close();
  }
}
