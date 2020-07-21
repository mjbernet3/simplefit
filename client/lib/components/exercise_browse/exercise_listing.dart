import 'package:client/app_style.dart';
import 'package:client/components/shared/app_divider.dart';
import 'package:client/components/exercise_browse/exercise_card.dart';
import 'package:client/components/shared/rounded_button.dart';
import 'package:client/models/exercise/exercise.dart';
import 'package:client/router.dart';
import 'package:client/services/exercise_service.dart';
import 'package:client/view_models/exercise_browse_model.dart';
import 'package:client/utils/structures/response.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExerciseListing extends StatefulWidget {
  @override
  _ExerciseListingState createState() => _ExerciseListingState();
}

class _ExerciseListingState extends State<ExerciseListing> {
  IconData listIcon = Icons.edit;
  bool isEditing = false;

  @override
  Widget build(BuildContext context) {
    ExerciseService _exerciseService =
        Provider.of<ExerciseService>(context, listen: false);

    return StreamBuilder<List<Exercise>>(
      stream: _exerciseService.exercises,
      builder: (BuildContext context, AsyncSnapshot<List<Exercise>> snapshot) {
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
                      onPressed: () =>
                          Navigator.pushNamed(context, Router.manageExercise),
                    ),
                  ],
                ),
              ),
            );
          }

          final List<Exercise> exercises = snapshot.data;

          return Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Choose exercises',
                        style: TextStyle(
                          color: AppStyle.highEmphasisText,
                          fontSize: 18.0,
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          GestureDetector(
                            onTap: () => setState(() => {
                                  if (isEditing)
                                    {
                                      listIcon = Icons.edit,
                                    }
                                  else
                                    {
                                      listIcon = Icons.check,
                                    },
                                  isEditing = !isEditing
                                }),
                            child: Container(
                              height: 24.0,
                              width: 24.0,
                              child: Icon(
                                listIcon,
                                color: AppStyle.highEmphasisText,
                                size: 20.0,
                              ),
                            ),
                          ),
                          SizedBox(width: 8.0),
                          !isEditing
                              ? GestureDetector(
                                  onTap: () => Navigator.pushNamed(
                                    context,
                                    Router.manageExercise,
                                  ),
                                  child: Icon(
                                    Icons.add,
                                    color: AppStyle.highEmphasisText,
                                  ),
                                )
                              : SizedBox.shrink(),
                        ],
                      ),
                    ],
                  ),
                ),
                AppDivider(),
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.all(0.0),
                    itemCount: exercises.length,
                    itemBuilder: (BuildContext context, int index) {
                      ExerciseBrowseModel browseModel =
                          Provider.of<ExerciseBrowseModel>(context,
                              listen: false);
                      return ExerciseCard(
                        exercise: exercises[index],
                        onPressed: isEditing
                            ? (Exercise exercise, _) => Navigator.pushNamed(
                                  context,
                                  Router.manageExercise,
                                  arguments: exercise,
                                )
                            : (Exercise exercise, bool selected) {
                                if (selected) {
                                  browseModel.addExercise(exercise);
                                } else {
                                  browseModel.removeExercise(exercise);
                                }
                              },
                        onRemovePressed: (String exerciseId) =>
                            _removeExercise(exerciseId),
                        isEditing: isEditing,
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        }

        return Container();
      },
    );
  }

  void _removeExercise(String exerciseId) async {
    ExerciseService _exerciseService =
        Provider.of<ExerciseService>(context, listen: false);

    Response response = await _exerciseService.removeExercise(exerciseId);

    if (response.status == Status.FAILURE) {
      // TODO: Handle backend error
    }
  }
}
