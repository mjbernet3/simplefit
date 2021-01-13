import 'package:client/utils/app_error.dart';
import 'package:client/utils/constants.dart';
import 'package:client/components/shared/action_buttons.dart';
import 'package:client/components/manage_exercise/exercise_dropdown.dart';
import 'package:client/components/shared/input_field.dart';
import 'package:client/models/exercise/exercise.dart';
import 'package:client/services/exercise_service.dart';
import 'package:client/utils/constants.dart';
import 'package:client/utils/validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ManageExercisePage extends StatefulWidget {
  final Exercise exercise;
  final bool isEdit;

  ManageExercisePage({this.exercise}) : isEdit = exercise != null;

  @override
  _ManageExercisePageState createState() => _ManageExercisePageState();
}

class _ManageExercisePageState extends State<ManageExercisePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _nameController;
  String _chosenType;
  String _chosenBodyPart;
  bool _isLoading = false;
  AutovalidateMode _autovalidate = AutovalidateMode.disabled;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();

    if (widget.isEdit) {
      _nameController.text = widget.exercise.name;
      _chosenType = widget.exercise.type;
      _chosenBodyPart = widget.exercise.bodyPart;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: _autovalidate,
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
                  fillColor: Constants.secondElevation,
                  enabled: !_isLoading,
                  onSubmitted: (_) => FocusScope.of(context).unfocus(),
                ),
                SizedBox(height: 20.0),
                ExerciseDropdown(
                  hintText: 'Select Exercise Type',
                  items: Constants.exerciseTypes,
                  enabled: !_isLoading,
                  initialValue: widget.isEdit ? widget.exercise.type : null,
                  onChanged: (String value) => setState(() => {
                        _chosenType = value,
                        _chosenBodyPart = null,
                      }),
                  validator: (String value) =>
                      Validator.validateExerciseType(value),
                ),
                SizedBox(height: 20.0),
                _chosenType == Constants.lifting
                    ? ExerciseDropdown(
                        hintText: 'Select Body Part',
                        items: Constants.bodyParts,
                        enabled: !_isLoading,
                        initialValue:
                            widget.isEdit ? widget.exercise.bodyPart : null,
                        onChanged: (String value) => _chosenBodyPart = value,
                        validator: (String value) =>
                            Validator.validateBodyPart(value, _chosenType),
                      )
                    : SizedBox.shrink(),
              ],
            ),
          ),
          ActionButtons(
            confirmText: widget.isEdit ? 'Update Exercise' : 'Create Exercise',
            color: Constants.secondElevation,
            disabled: _isLoading,
            onConfirmed: () => _manageExercise(),
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
        exerciseName = 'My Exercise';
      }

      Exercise newExercise = Exercise(
        name: exerciseName,
        type: _chosenType,
        bodyPart: _chosenBodyPart,
      );

      setState(() => _isLoading = true);

      try {
        if (!widget.isEdit) {
          await exerciseService.createExercise(newExercise);
        } else {
          if (!newExercise.equals(widget.exercise)) {
            await exerciseService.updateExercise(
                widget.exercise.id, newExercise);
          }
        }

        Navigator.pop(context);
      } catch (e) {
        setState(() => _isLoading = false);
        AppError.show(context, e.message);
      }
    } else {
      setState(() => _autovalidate = AutovalidateMode.always);
    }
  }
}
