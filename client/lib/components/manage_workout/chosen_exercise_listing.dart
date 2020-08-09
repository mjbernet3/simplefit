import 'package:client/app_style.dart';
import 'package:client/components/manage_workout/chosen_exercise_card.dart';
import 'package:client/components/shared/app_divider.dart';
import 'package:client/components/shared/rounded_button.dart';
import 'package:client/models/exercise/exercise.dart';
import 'package:client/models/exercise/exercise_data.dart';
import 'package:client/router.dart';
import 'package:client/view_models/manage_workout_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChosenExerciseListing extends StatefulWidget {
  @override
  _ChosenExerciseListingState createState() => _ChosenExerciseListingState();
}

class _ChosenExerciseListingState extends State<ChosenExerciseListing> {
  bool isEditing = false;

  @override
  Widget build(BuildContext context) {
    ManageWorkoutModel model =
        Provider.of<ManageWorkoutModel>(context, listen: false);
    return Column(
      children: <Widget>[
        Align(
          alignment: Alignment.center,
          child: Text(
            'Exercises',
            style: TextStyle(
              fontSize: 18.0,
              color: AppStyle.highEmphasisText,
            ),
          ),
        ),
        AppDivider(),
        Expanded(
          child: ListView(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  StreamBuilder<List<ExerciseData>>(
                    stream: model.exerciseStream,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<ExerciseData> exercises = snapshot.data;

                        return ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: exercises.length,
                          itemBuilder: (BuildContext context, int index) {
                            ExerciseData currentExercise = exercises[index];

                            return ChosenExerciseCard(
                              exerciseData: currentExercise,
                              onPressed: () =>
                                  _detailExercise(currentExercise, index),
                              onRemovePressed: () =>
                                  model.removeExerciseAt(index),
                              isEditing: isEditing,
                            );
                          },
                        );
                      }

                      return Container();
                    },
                  ),
                  RoundedButton(
                    buttonText: Text(
                      'Add Exercise',
                      style: TextStyle(
                        color: AppStyle.highEmphasisText,
                      ),
                    ),
                    height: 30.0,
                    color: AppStyle.dp4,
                    borderColor: AppStyle.dp4,
                    onPressed: () => _browseExercises(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _browseExercises() async {
    List<Exercise> chosenExercises =
        await Navigator.pushNamed(context, Router.browser);

    if (chosenExercises != null) {
      ManageWorkoutModel model =
          Provider.of<ManageWorkoutModel>(context, listen: false);

      model.initExercises(chosenExercises);
    }
  }

  void _detailExercise(ExerciseData exercise, int position) async {
    ExerciseData newExerciseData = await Navigator.pushNamed(
      context,
      Router.exerciseDetail,
      arguments: exercise,
    );

    if (newExerciseData != null) {
      ManageWorkoutModel model =
          Provider.of<ManageWorkoutModel>(context, listen: false);
      model.updateExerciseAt(position, newExerciseData);
    }
  }
}
