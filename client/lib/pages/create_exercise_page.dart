import 'package:client/app_style.dart';
import 'package:client/components/shared/app_divider.dart';
import 'package:client/components/shared/exercise_dropdown.dart';
import 'package:client/components/shared/input_field.dart';
import 'package:client/components/shared/rounded_button.dart';
import 'package:client/models/exercise/exercise.dart';
import 'package:client/services/exercise_service.dart';
import 'package:client/utils/constants.dart';
import 'package:client/utils/structures/response.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateExercisePage extends StatefulWidget {
  @override
  _CreateExercisePageState createState() => _CreateExercisePageState();
}

class _CreateExercisePageState extends State<CreateExercisePage> {
  TextEditingController _nameController;
  String chosenExercise;
  String chosenBodyPart;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              InputField(
                labelText: 'Exercise Name',
                controller: _nameController,
                fillColor: AppStyle.dp8,
                onSubmitted: (_) => FocusScope.of(context).unfocus(),
              ),
              SizedBox(height: 20.0),
              ExerciseDropdown(
                hintText: 'Select Exercise Type',
                items: kExerciseTypes,
                onChanged: (String value) => setState(() => {
                      chosenExercise = value,
                      chosenBodyPart = null,
                    }),
              ),
              SizedBox(height: 20.0),
              chosenExercise == kExerciseTypes[0]
                  ? ExerciseDropdown(
                      hintText: 'Select Body Part',
                      items: kBodyParts,
                      onChanged: (String value) => chosenBodyPart = value,
                    )
                  : SizedBox.shrink(),
            ],
          ),
        ),
        Column(
          children: <Widget>[
            AppDivider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                RoundedButton(
                  buttonText: Text(
                    'Cancel',
                    style: TextStyle(color: AppStyle.highEmphasisText),
                  ),
                  height: 30.0,
                  color: AppStyle.dp4,
                  borderColor: AppStyle.dp4,
                  onPressed: () => Navigator.pop(context),
                ),
                RoundedButton(
                  buttonText: Text(
                    'Create Exercise',
                    style: TextStyle(color: AppStyle.highEmphasisText),
                  ),
                  height: 30.0,
                  color: AppStyle.dp4,
                  borderColor: AppStyle.dp4,
                  onPressed: () => _createExercise(),
                ),
              ],
            ),
          ],
        )
      ],
    );
  }

  void _createExercise() async {
    ExerciseService exerciseService =
        Provider.of<ExerciseService>(context, listen: false);

    String exerciseName = _nameController.text;
    Exercise newExercise = Exercise(
        name: exerciseName, type: chosenExercise, bodyPart: chosenBodyPart);

    Response response = await exerciseService.createExercise(newExercise);

    if (response.status == Status.SUCCESS) {
      Navigator.pop(context);
    } else {
      // TODO: Handle backend error
    }
  }
}
