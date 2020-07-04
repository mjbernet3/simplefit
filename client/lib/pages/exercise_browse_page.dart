import 'package:client/app_style.dart';
import 'package:client/components/shared/app_divider.dart';
import 'package:client/components/shared/exercise_card.dart';
import 'package:client/components/shared/rounded_button.dart';
import 'package:client/models/exercise/exercise.dart';
import 'package:client/router.dart';
import 'package:client/services/exercise_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExerciseBrowsePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ExerciseService _exerciseService =
        Provider.of<ExerciseService>(context, listen: false);
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        StreamBuilder<List<Exercise>>(
          stream: _exerciseService.exercises,
          builder:
              (BuildContext context, AsyncSnapshot<List<Exercise>> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.isEmpty) {
                return Expanded(
                  child: Center(
                    child: Text(
                      'You have no exercises.',
                      style: TextStyle(
                        color: AppStyle.medEmphasisText,
                      ),
                    ),
                  ),
                );
              }

              final List<Exercise> exercises = snapshot.data;

              return Expanded(
                child: ListView.builder(
                  itemCount: exercises.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ExerciseCard(
                      exercise: exercises[index],
                      onPressed: () => print('hello'),
                      onRemovePressed: () => print('removing'),
                      isEditing: false,
                    );
                  },
                ),
              );
            }

            return Container();
          },
        ),
        AppDivider(),
        RoundedButton(
          buttonText: Text(
            'Create Exercise',
            style: TextStyle(color: AppStyle.highEmphasisText),
          ),
          height: 30.0,
          color: AppStyle.dp4,
          borderColor: AppStyle.dp4,
          onPressed: () => Navigator.pushNamed(context, Router.createExercise),
        ),
      ],
    );
  }
}
