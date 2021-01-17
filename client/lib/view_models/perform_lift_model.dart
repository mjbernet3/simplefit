import 'dart:async';
import 'package:client/models/exercise/lift_set.dart';
import 'package:client/models/exercise/weight_lift.dart';
import 'package:client/view_models/view_model.dart';

class PerformLiftModel extends ViewModel {
  WeightLift _liftData;
  int _currentIndex;

  PerformLiftModel(WeightLift liftData) {
    _liftData = liftData;
    _currentIndex = 0;
    _setController.sink.add(_liftData.sets[0]);
  }

  final StreamController<LiftSet> _setController = StreamController<LiftSet>();

  Stream<LiftSet> get setStream => _setController.stream;

  int get setNumber => _currentIndex + 1;

  bool get shouldAdvance => _liftData.shouldAdvance;

  bool hasNext() {
    return (_currentIndex + 1) < _liftData.sets.length;
  }

  void next() {
    _currentIndex++;
    _setController.sink.add(_liftData.sets[_currentIndex]);
  }

  @override
  void dispose() {
    _setController.close();
  }
}
