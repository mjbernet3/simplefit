import 'dart:async';
import 'package:client/models/exercise/lift_set.dart';
import 'package:client/models/exercise/weight_lift.dart';
import 'package:client/view_models/view_model.dart';

class PerformLiftModel extends ViewModel {
  WeightLift _liftData;
  int _currentIndex;
  bool _isResting = false;

  PerformLiftModel(WeightLift liftData) {
    _liftData = liftData;
    _currentIndex = 0;
    _isResting = false;
    _setController.sink.add(_liftData.sets[0]);
  }

  final StreamController<LiftSet> _setController = StreamController<LiftSet>();

  final StreamController<bool> _restingController = StreamController<bool>();

  Stream<LiftSet> get setStream => _setController.stream;

  Stream<bool> get isResting => _restingController.stream;

  int get setNumber => _currentIndex + 1;

  bool get shouldAdvance => _liftData.shouldAdvance;

  bool hasNext() {
    return (_currentIndex + 1) < _liftData.sets.length;
  }

  void next() {
    LiftSet currentSet = _liftData.sets[_currentIndex];

    if (!_isResting && currentSet.rest > 0) {
      _isResting = true;
      _restingController.sink.add(_isResting);
    } else {
      _currentIndex++;
      _setController.sink.add(_liftData.sets[_currentIndex]);

      _isResting = false;
      _restingController.sink.add(_isResting);
    }
  }

  @override
  void dispose() {
    _setController.close();
    _restingController.close();
  }
}
