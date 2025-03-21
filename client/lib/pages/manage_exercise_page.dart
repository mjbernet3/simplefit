import 'package:client/utils/app_error.dart';
import 'package:client/utils/constants.dart';
import 'package:client/components/shared/action_buttons.dart';
import 'package:client/components/shared/app_dropdown_button.dart';
import 'package:client/components/shared/input_field.dart';
import 'package:client/models/exercise/exercise.dart';
import 'package:client/utils/validator.dart';
import 'package:client/view_models/manage_exercise_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ManageExercisePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ManageExerciseModel model =
        Provider.of<ManageExerciseModel>(context, listen: false);

    return StreamBuilder<bool>(
      initialData: false,
      stream: model.autovalidate,
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        bool autovalidate = snapshot.data ?? false;

        return Form(
          key: model.formKey,
          autovalidateMode: autovalidate
              ? AutovalidateMode.always
              : AutovalidateMode.disabled,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: StreamBuilder<Exercise>(
                  stream: model.exercise,
                  builder:
                      (BuildContext context, AsyncSnapshot<Exercise> snapshot) {
                    if (snapshot.hasData) {
                      Exercise exercise = snapshot.data!;

                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          InputField(
                            labelText: 'Exercise Name',
                            controller: model.nameController,
                            maxLength: Constants.maxExerciseNameLength,
                            color: Constants.secondElevation,
                            onSubmitted: (_) =>
                                FocusScope.of(context).unfocus(),
                          ),
                          const SizedBox(height: 20.0),
                          AppDropdownButton(
                            hintText: 'Select Exercise Type',
                            items: Constants.exerciseTypes,
                            initialValue:
                                model.isEditMode ? exercise.type : "",
                            onChanged: (String value) =>
                                model.setExerciseType(value),
                            validator: _checkExerciseType,
                          ),
                          const SizedBox(height: 20.0),
                          exercise.type == Constants.lifting
                              ? AppDropdownButton(
                                  hintText: 'Select Body Part',
                                  items: Constants.bodyParts,
                                  initialValue: model.isEditMode
                                      ? exercise.bodyPart : null,
                                  onChanged: (String value) =>
                                      exercise.bodyPart = value,
                                  validator: (String? value) =>
                                      _checkBodyPart(value, exercise.type),
                                )
                              : const SizedBox.shrink(),
                        ],
                      );
                    }

                    return const SizedBox.shrink();
                  },
                ),
              ),
              ActionButtons(
                confirmText:
                    model.isEditMode ? 'Update Exercise' : 'Create Exercise',
                color: Constants.secondElevation,
                onConfirmed: () => _saveExercise(context),
              ),
            ],
          ),
        );
      },
    );
  }

  String _checkExerciseType(String? exerciseType) {

    // TODO: Improve error handling
    try {
      Validator.validateExerciseType(exerciseType);
    } catch (e) {
      return e.toString();
    }

    return "";
  }

  String _checkBodyPart(String? bodyPart, String? exerciseType) {

    // TODO: Improve error handling
    try {
      Validator.validateBodyPart(bodyPart, exerciseType);
    } catch (e) {
      return e.toString();
    }

    return "";
  }

  void _saveExercise(BuildContext context) async {
    ManageExerciseModel model =
        Provider.of<ManageExerciseModel>(context, listen: false);

    // TODO: Improve error handling
    try {
      bool success = model.saveExercise();

      if (success) {
        Navigator.pop(context);
      }
    } catch (e) {
      AppError.show(context, e.toString());
    }
  }
}
