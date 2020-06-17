import 'package:client/models/abstract/exercise.dart';
import 'package:client/models/lift_set.dart';

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
