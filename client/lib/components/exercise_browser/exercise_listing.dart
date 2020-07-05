import 'package:client/components/shared/exercise_card.dart';
import 'package:client/models/exercise/exercise.dart';
import 'package:client/state_models/state_model.dart';
import 'package:client/utils/page_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExerciseListing extends StatelessWidget {
  final List<Exercise> exercises;

  const ExerciseListing({this.exercises});

  @override
  Widget build(BuildContext context) {
    StateModel browseModel = Provider.of<StateModel>(context);
    return ListView.builder(
      padding: EdgeInsets.all(0.0),
      itemCount: exercises.length,
      itemBuilder: (BuildContext context, int index) {
        return ExerciseCard(
          exercise: exercises[index],
          onPressed: () => print('hello'),
          onRemovePressed: () => print('removing'),
          isEditing: browseModel.state == PageState.EDITING,
        );
      },
    );
  }
}
