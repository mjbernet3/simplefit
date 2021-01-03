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
  }) : super(exercise, notes, 0, isWarmUp);

  factory WeightLift.initial(Exercise exercise) {
    return WeightLift(
      exercise: exercise,
      notes: '',
      rest: 0,
      isWarmUp: false,
      sets: [],
    );
  }

  factory WeightLift.copy(WeightLift other) {
    List<LiftSet> otherSets =
        other.sets.map((LiftSet set) => LiftSet.copy(set)).toList();

    return WeightLift(
      exercise: other.exercise,
      notes: other.notes,
      rest: 0,
      isWarmUp: other.isWarmUp,
      sets: otherSets,
    );
  }

  factory WeightLift.fromJson(Map<String, dynamic> exerciseData) {
    Exercise exercise = Exercise.fromJson(exerciseData['exercise']);

    List<dynamic> setList = exerciseData['sets'] as List;
    List<LiftSet> sets = setList.map((set) => LiftSet.fromJson(set)).toList();

    return WeightLift(
      exercise: exercise,
      notes: exerciseData['notes'],
      rest: 0,
      isWarmUp: exerciseData['isWarmUp'],
      sets: sets,
    );
  }

  Map<String, dynamic> toJson() {
    List<dynamic> setList = sets.map((set) => set.toJson()).toList();

    return {
      'exercise': exercise.toJson(),
      'notes': notes,
      'isWarmUp': isWarmUp,
      'sets': setList,
    };
  }
}
