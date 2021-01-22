import 'dart:async';
import 'package:client/models/exercise/lift_set.dart';
import 'package:client/models/exercise/weight_lift.dart';
import 'package:client/view_models/view_model.dart';

class PerformLiftModel extends ViewModel {
  WeightLift _weightLift;
  int _currentIndex;
  bool _isResting = false;

  PerformLiftModel({WeightLift weightLift}) {
    _weightLift = weightLift;
    _currentIndex = 0;
    _isResting = false;
    _setController.sink.add(_weightLift.sets[0]);
  }

  final StreamController<LiftSet> _setController = StreamController<LiftSet>();

  final StreamController<bool> _restingController = StreamController<bool>();

  Stream<LiftSet> get set => _setController.stream;

  Stream<bool> get isResting => _restingController.stream;

  int get setNumber => _currentIndex + 1;

  bool get shouldAdvance => _weightLift.shouldAdvance;

  bool hasNext() {
    return (_currentIndex + 1) < _weightLift.sets.length;
  }

  void next() {
    LiftSet currentSet = _weightLift.sets[_currentIndex];

    if (!_isResting && currentSet.rest > 0) {
      _isResting = true;
      _restingController.sink.add(_isResting);
    } else {
      _currentIndex++;
      _setController.sink.add(_weightLift.sets[_currentIndex]);

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
