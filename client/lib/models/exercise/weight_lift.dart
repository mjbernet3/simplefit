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
    bool shouldAdvance,
    this.sets,
  }) : super(exercise, notes, 0, isWarmUp, shouldAdvance);

  factory WeightLift.initial(Exercise exercise) {
    return WeightLift(
      exercise: exercise,
      notes: '',
      rest: 0,
      isWarmUp: false,
      shouldAdvance: false,
      sets: [LiftSet.initial()],
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
      shouldAdvance: exerciseData['shouldAdvance'],
      sets: sets,
    );
  }

  Map<String, dynamic> toJson() {
    List<dynamic> setList = sets.map((set) => set.toJson()).toList();

    return {
      'exercise': exercise.toJson(),
      'notes': notes,
      'isWarmUp': isWarmUp,
      'shouldAdvance': shouldAdvance,
      'sets': setList,
    };
  }

  WeightLift clone() {
    List<LiftSet> copiedSets = sets.map((LiftSet set) => set.copy()).toList();

    return WeightLift(
      exercise: exercise,
      notes: notes,
      rest: 0,
      isWarmUp: isWarmUp,
      shouldAdvance: shouldAdvance,
      sets: copiedSets,
    );
  }

  void printExercise() {
    print(exercise.name);
    print(notes);
    print(rest);
    print(isWarmUp);
    print(shouldAdvance);
    sets.forEach((set) => {
          print(set.rest),
          print(set.isWarmUp),
          print(set.weight),
          print(set.reps),
          print(set.targetReps),
        });
  }
}
