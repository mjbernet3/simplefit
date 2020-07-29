import 'dart:async';
import 'package:client/models/exercise/lift_set.dart';
import 'package:client/models/exercise/weight_lift.dart';
import 'package:client/view_models/view_model.dart';

class LiftDetailModel extends ViewModel {
  WeightLift liftData;

  final StreamController<List<LiftSet>> _setController =
      StreamController<List<LiftSet>>();
  final StreamController<bool> _warmUpController = StreamController<bool>();

  Stream<List<LiftSet>> get setStream => _setController.stream;
  Stream<bool> get warmUpStream => _warmUpController.stream;

  LiftDetailModel(WeightLift liftData) {
    // Copy provided data so that changes do not take effect before saving
    this.liftData = WeightLift.copy(liftData);

    if (liftData.sets.isEmpty) {
      liftData.sets.add(LiftSet.initial());
    }

    _setController.sink.add(liftData.sets);
    _warmUpController.sink.add(liftData.isWarmUp);
  }

  void addSet() {
    liftData.sets.add(LiftSet.initial());

    _setController.sink.add(liftData.sets);
  }

  void removeSet(int index) {
    liftData.sets.removeAt(index);

    _setController.sink.add(liftData.sets);
  }

  void toggleWarmUp() {
    liftData.isWarmUp = !liftData.isWarmUp;

    _warmUpController.sink.add(liftData.isWarmUp);
  }

  @override
  void dispose() {
    _setController.close();
    _warmUpController.close();
  }
}
