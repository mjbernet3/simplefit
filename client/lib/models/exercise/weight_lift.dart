import 'package:client/models/exercise/exercise.dart';
import 'package:client/models/exercise/lift_set.dart';

class WeightLift extends Exercise {
  final List<LiftSet> sets;

  WeightLift({
    String name,
    String type,
    String notes,
    int rest,
    bool isWarmUp,
    this.sets,
  }) : super(name, type, notes, rest, isWarmUp);

  factory WeightLift.fromJson(Map<String, dynamic> exerciseData) {
    List<dynamic> setList = exerciseData['sets'] as List;

    List<LiftSet> sets = setList.map((set) => LiftSet.fromJson(set)).toList();

    return WeightLift(
      name: exerciseData['name'],
      type: exerciseData['type'],
      notes: exerciseData['notes'],
      rest: exerciseData['rest'],
      isWarmUp: exerciseData['isWarmUp'],
      sets: sets,
    );
  }

  Map<String, dynamic> toJson() {
    List<dynamic> setList = sets.map((set) => set.toJson()).toList();

    return {
      'name': name,
      'type': type,
      'notes': notes,
      'rest': rest,
      'isWarmUp': isWarmUp,
      'sets': setList,
    };
  }
}
