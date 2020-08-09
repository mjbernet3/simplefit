import 'dart:async';
import 'package:client/models/exercise/timed_cardio.dart';
import 'package:client/view_models/view_model.dart';

class TimedDetailModel extends ViewModel {
  TimedCardio timedData;

  final StreamController<bool> _warmUpController = StreamController<bool>();

  Stream<bool> get warmUpStream => _warmUpController.stream;

  TimedDetailModel(TimedCardio timedData) {
    // Copy provided data so that changes do not take effect before saving
    this.timedData = TimedCardio.copy(timedData);

    _warmUpController.sink.add(timedData.isWarmUp);
  }

  void toggleWarmUp() {
    timedData.isWarmUp = !timedData.isWarmUp;

    _warmUpController.sink.add(timedData.isWarmUp);
  }

  @override
  void dispose() {
    _warmUpController.close();
  }
}
