import 'dart:async';
import 'package:client/models/exercise/lift_set.dart';
import 'package:client/models/exercise/weight_lift.dart';
import 'package:client/view_models/view_model.dart';

class DetailLiftModel extends ViewModel {
  List<LiftSet> _sets;

  DetailLiftModel(WeightLift liftData) {
    _sets = liftData.sets;

    if (_sets.isEmpty) {
      _sets.add(LiftSet.initial());
    }

    _setsController.sink.add(_sets);
  }

  final StreamController<List<LiftSet>> _setsController =
      StreamController<List<LiftSet>>();

  Stream<List<LiftSet>> get setsStream => _setsController.stream;

  void addSet() {
    _sets.add(LiftSet.initial());

    _setsController.sink.add(_sets);
  }

  void removeSetAt(int index) {
    _sets.removeAt(index);

    _setsController.sink.add(_sets);
  }

  @override
  void dispose() {
    _setsController.close();
  }
}
