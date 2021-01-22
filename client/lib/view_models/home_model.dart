import 'dart:async';
import 'package:client/models/workout/workout.dart';
import 'package:client/services/workout_service.dart';
import 'package:client/view_models/view_model.dart';

class HomeModel extends ViewModel {
  WorkoutService _workoutService;

  HomeModel({WorkoutService workoutService}) {
    _workoutService = workoutService;
  }

  final StreamController<bool> _loadingController = StreamController<bool>();

  final StreamController<bool> _editingController = StreamController<bool>();

  Stream<bool> get isLoading => _loadingController.stream;

  Stream<bool> get isEditing => _editingController.stream;

  void setEditing(bool value) {
    _editingController.sink.add(value);
  }

  Future<Workout> getWorkout(String workoutId) async {
    _loadingController.sink.add(true);

    try {
      Workout _workout = await _workoutService.getWorkout(workoutId);
      _loadingController.sink.add(false);
      return _workout;
    } catch (e) {
      _loadingController.sink.add(false);
      rethrow;
    }
  }

  @override
  void dispose() {
    _loadingController.close();
    _editingController.close();
  }
}
