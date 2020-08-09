import 'package:client/app_style.dart';
import 'package:client/components/exercise_browse/exercise_listing.dart';
import 'package:client/components/shared/app_divider.dart';
import 'package:client/components/shared/rounded_button.dart';
import 'package:client/models/exercise/exercise.dart';
import 'package:client/router.dart';
import 'package:client/services/exercise_service.dart';
import 'package:client/view_models/exercise_browse_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExerciseBrowsePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ExerciseService _exerciseService =
        Provider.of<ExerciseService>(context, listen: false);
    ExerciseBrowseModel model =
        Provider.of<ExerciseBrowseModel>(context, listen: false);
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        StreamBuilder<List<Exercise>>(
          stream: _exerciseService.exercises,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.isEmpty) {
                return Expanded(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'You have no exercises.',
                          style: TextStyle(
                            color: AppStyle.medEmphasisText,
                          ),
                        ),
                        SizedBox(height: 5.0),
                        RoundedButton(
                          buttonText: Text(
                            'Add Exercise',
                            style: TextStyle(color: AppStyle.highEmphasisText),
                          ),
                          height: 30.0,
                          color: AppStyle.dp4,
                          borderColor: AppStyle.dp4,
                          onPressed: () => Navigator.pushNamed(
                              context, Router.manageExercise),
                        ),
                      ],
                    ),
                  ),
                );
              }

              final List<Exercise> exercises = snapshot.data;

              return ExerciseListing(exercises: exercises);
            }

            return Container();
          },
        ),
        StreamBuilder<int>(
          stream: model.exerciseCountStream,
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data != 0) {
              int exerciseCount = snapshot.data;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  AppDivider(),
                  RoundedButton(
                    buttonText: Text(
                      'Add $exerciseCount Exercises',
                      style: TextStyle(color: AppStyle.highEmphasisText),
                    ),
                    height: 30.0,
                    color: AppStyle.dp4,
                    borderColor: AppStyle.dp4,
                    onPressed: () =>
                        Navigator.pop(context, model.getExercises()),
                  ),
                ],
              );
            }

            return Container();
          },
        ),
      ],
    );
  }
}
