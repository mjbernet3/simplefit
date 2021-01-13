import 'package:client/components/manage_workout/chosen_exercise_card.dart';
import 'package:client/components/shared/rounded_button.dart';
import 'package:client/models/exercise/exercise.dart';
import 'package:client/models/exercise/exercise_data.dart';
import 'package:client/utils/app_router.dart';
import 'package:client/view_models/manage_workout_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChosenExerciseListing extends StatefulWidget {
  @override
  _ChosenExerciseListingState createState() => _ChosenExerciseListingState();
}

class _ChosenExerciseListingState extends State<ChosenExerciseListing> {
  bool isEditing = false;
  IconData listIcon = Icons.edit;

  @override
  Widget build(BuildContext context) {
    ManageWorkoutModel model =
        Provider.of<ManageWorkoutModel>(context, listen: false);
    return StreamBuilder<List<ExerciseData>>(
      stream: model.exerciseStream,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Align(
                alignment: Alignment.center,
                child: Text(
                  'Exercises',
                  style: TextStyle(fontSize: 18.0),
                ),
              ),
              Divider(),
              RoundedButton(
                buttonText: 'Add Exercise',
                height: 30.0,
                onPressed: _browseExercises,
              ),
            ],
          );
        }

        List<ExerciseData> exercises = snapshot.data;

        return Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Exercises',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  Row(
                    children: <Widget>[
                      GestureDetector(
                        onTap: () => setState(
                          () => {
                            if (isEditing)
                              {
                                listIcon = Icons.edit,
                              }
                            else
                              {
                                listIcon = Icons.check,
                              },
                            isEditing = !isEditing
                          },
                        ),
                        child: Container(
                          height: 24.0,
                          width: 24.0,
                          child: Icon(
                            listIcon,
                            size: 20.0,
                          ),
                        ),
                      ),
                      SizedBox(width: 8.0),
                      !isEditing
                          ? GestureDetector(
                              onTap: _browseExercises,
                              child: Icon(Icons.add),
                            )
                          : SizedBox.shrink(),
                    ],
                  ),
                ],
              ),
            ),
            Divider(),
            Expanded(
              child: ListView(
                children: <Widget>[
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: exercises.length,
                    itemBuilder: (BuildContext context, int index) {
                      ExerciseData currentExercise = exercises[index];

                      return ChosenExerciseCard(
                        key: ObjectKey(currentExercise),
                        exerciseData: currentExercise,
                        onPressed: () =>
                            _detailExercise(currentExercise, index),
                        onRemovePressed: () => model.removeExerciseAt(index),
                        isEditing: isEditing,
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  void _browseExercises() async {
    List<Exercise> chosenExercises =
        await Navigator.pushNamed(context, AppRouter.browseExercises);

    if (chosenExercises != null) {
      ManageWorkoutModel model =
          Provider.of<ManageWorkoutModel>(context, listen: false);

      model.initExercises(chosenExercises);
    }
  }

  void _detailExercise(ExerciseData exercise, int position) async {
    ExerciseData newExerciseData = await Navigator.pushNamed(
      context,
      AppRouter.detailExercise,
      arguments: exercise.copy(),
    );

    if (newExerciseData != null) {
      ManageWorkoutModel model =
          Provider.of<ManageWorkoutModel>(context, listen: false);
      model.updateExerciseAt(position, newExerciseData);
    }
  }
}
