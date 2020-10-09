import 'dart:async';
import 'package:client/models/exercise/lift_set.dart';
import 'package:client/models/exercise/weight_lift.dart';
import 'package:client/view_models/view_model.dart';

class LiftDetailModel extends ViewModel {
  List<LiftSet> _sets;

  final StreamController<List<LiftSet>> _setController =
      StreamController<List<LiftSet>>();

  Stream<List<LiftSet>> get setStream => _setController.stream;

  LiftDetailModel(WeightLift liftData) {
    this._sets = liftData.sets;

    if (_sets.isEmpty) {
      _sets.add(LiftSet.initial());
    }

    _setController.sink.add(_sets);
  }

  List<LiftSet> getSets() {
    return _sets;
  }

  void addSet() {
    _sets.add(LiftSet.initial());

    _setController.sink.add(_sets);
  }

  void removeSetAt(int index) {
    _sets.removeAt(index);

    _setController.sink.add(_sets);
  }

  @override
  void dispose() {
    _setController.close();
  }
}
