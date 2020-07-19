import 'package:client/models/exercise/exercise.dart';
import 'package:client/models/exercise/exercise_data.dart';
import 'package:client/models/exercise/lift_set.dart';

class WeightLift extends ExerciseData {
  List<LiftSet> sets;

  WeightLift({
    Exercise exercise,
    String notes,
    int rest,
    bool isWarmUp,
    this.sets,
  }) : super(exercise, notes, rest, isWarmUp);

  factory WeightLift.initial(Exercise exercise) {
    return WeightLift(
      exercise: exercise,
      notes: '',
      rest: 0,
      isWarmUp: false,
      sets: [],
    );
  }

  factory WeightLift.fromJson(Map<String, dynamic> exerciseData) {
    List<dynamic> setList = exerciseData['sets'] as List;

    List<LiftSet> sets = setList.map((set) => LiftSet.fromJson(set)).toList();

    return WeightLift(
      exercise: exerciseData['exercise'],
      notes: exerciseData['notes'],
      rest: exerciseData['rest'],
      isWarmUp: exerciseData['isWarmUp'],
      sets: sets,
    );
  }

  Map<String, dynamic> toJson() {
    List<dynamic> setList = sets.map((set) => set.toJson()).toList();

    return {
      'exercise': exercise,
      'notes': notes,
      'rest': rest,
      'isWarmUp': isWarmUp,
      'sets': setList,
    };
  }
}
