import 'package:client/models/exercise/exercise.dart';
import 'package:client/models/exercise/exercise_data.dart';
import 'package:client/models/exercise/lift_set.dart';

class WeightLift extends ExerciseData {
  List<LiftSet> sets;

  WeightLift({
    Exercise exercise,
    String notes,
    int rest, // Rest is always 0 since sets have rest
    bool isWarmUp,
    this.sets,
  }) : super(exercise, notes, 0, isWarmUp);

  factory WeightLift.initial(Exercise exercise) {
    return WeightLift(
      exercise: exercise,
      notes: '',
      isWarmUp: false,
      sets: [LiftSet.initial()],
    );
  }

  factory WeightLift.fromJson(Map<String, dynamic> json) {
    Exercise exercise = Exercise.fromJson(json['exercise']);

    List<dynamic> setList = json['sets'] as List;
    List<LiftSet> sets = setList.map((set) => LiftSet.fromJson(set)).toList();

    return WeightLift(
      exercise: exercise,
      notes: json['notes'],
      isWarmUp: json['isWarmUp'],
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

  WeightLift clone() {
    List<LiftSet> clonedSets = sets.map((set) => set.clone()).toList();

    return WeightLift(
      exercise: exercise,
      notes: notes,
      isWarmUp: isWarmUp,
      sets: clonedSets,
    );
  }
}
