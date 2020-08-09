import 'dart:async';
import 'package:client/models/exercise/distance_cardio.dart';
import 'package:client/view_models/view_model.dart';

class DistanceDetailModel extends ViewModel {
  DistanceCardio distanceData;

  final StreamController<bool> _warmUpController = StreamController<bool>();

  Stream<bool> get warmUpStream => _warmUpController.stream;

  DistanceDetailModel(DistanceCardio distanceData) {
    // Copy provided data so that changes do not take effect before saving
    this.distanceData = DistanceCardio.copy(distanceData);

    _warmUpController.sink.add(distanceData.isWarmUp);
  }

  void toggleWarmUp() {
    distanceData.isWarmUp = !distanceData.isWarmUp;

    _warmUpController.sink.add(distanceData.isWarmUp);
  }

  @override
  void dispose() {
    _warmUpController.close();
  }
}
