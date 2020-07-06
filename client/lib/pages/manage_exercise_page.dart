import 'package:client/app_style.dart';
import 'package:client/components/shared/app_divider.dart';
import 'package:client/components/shared/exercise_dropdown.dart';
import 'package:client/components/shared/input_field.dart';
import 'package:client/components/shared/rounded_button.dart';
import 'package:client/models/exercise/exercise.dart';
import 'package:client/services/exercise_service.dart';
import 'package:client/utils/constants.dart';
import 'package:client/utils/structures/response.dart';
import 'package:client/utils/validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ManageExercisePage extends StatefulWidget {
  final Exercise exercise;

  ManageExercisePage({this.exercise});

  @override
  _ManageExercisePageState createState() => _ManageExercisePageState();
}

class _ManageExercisePageState extends State<ManageExercisePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _nameController;
  String chosenType;
  String chosenBodyPart;
  bool isLoading = false;
  bool autovalidate = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();

    if (widget.exercise != null) {
      _nameController.text = widget.exercise.name;
      chosenType = widget.exercise.type;
      chosenBodyPart = widget.exercise.bodyPart;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidate: autovalidate,
      child: Column(
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
                  enabled: !isLoading,
                  onSubmitted: (_) => FocusScope.of(context).unfocus(),
                ),
                SizedBox(height: 20.0),
                ExerciseDropdown(
                  hintText: 'Select Exercise Type',
                  items: kExerciseTypes,
                  enabled: !isLoading,
                  initialValue:
                      widget.exercise != null ? widget.exercise.type : null,
                  onChanged: (String value) => setState(() => {
                        chosenType = value,
                        chosenBodyPart = null,
                      }),
                  validator: (String value) =>
                      Validator.validateExerciseType(value),
                ),
                SizedBox(height: 20.0),
                chosenType == kExerciseTypes[0]
                    ? ExerciseDropdown(
                        hintText: 'Select Body Part',
                        items: kBodyParts,
                        enabled: !isLoading,
                        initialValue: widget.exercise != null
                            ? widget.exercise.bodyPart
                            : null,
                        onChanged: (String value) => chosenBodyPart = value,
                        validator: (String value) =>
                            Validator.validateBodyPart(value, chosenType),
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
                    disabled: isLoading,
                    onPressed: () => Navigator.pop(context),
                  ),
                  RoundedButton(
                    buttonText: Text(
                      widget.exercise != null
                          ? 'Update Exercise'
                          : 'Create Exercise',
                      style: TextStyle(color: AppStyle.highEmphasisText),
                    ),
                    height: 30.0,
                    color: AppStyle.dp4,
                    borderColor: AppStyle.dp4,
                    disabled: isLoading,
                    onPressed: () => _manageExercise(),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _manageExercise() async {
    if (_formKey.currentState.validate()) {
      ExerciseService exerciseService =
          Provider.of<ExerciseService>(context, listen: false);

      String exerciseName = _nameController.text;
      if (exerciseName.isEmpty) {
        exerciseName = 'My Workout';
      }

      Exercise newExercise = Exercise(
        name: exerciseName,
        type: chosenType,
        bodyPart: chosenBodyPart,
      );

      setState(() => isLoading = true);

      Response response;
      if (widget.exercise == null) {
        response = await exerciseService.createExercise(newExercise);
      } else {
        if (!newExercise.equals(widget.exercise)) {
          response = await exerciseService.editExercise(
              widget.exercise.id, newExercise);
        } else {
          Navigator.pop(context);
          return;
        }
      }

      setState(() => isLoading = false);

      if (response.status == Status.SUCCESS) {
        Navigator.pop(context);
      } else {
        // TODO: Handle backend error
      }
    } else {
      setState(() => autovalidate = true);
    }
  }
}
