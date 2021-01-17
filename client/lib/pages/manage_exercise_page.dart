import 'package:client/utils/app_error.dart';
import 'package:client/utils/constants.dart';
import 'package:client/components/shared/action_buttons.dart';
import 'package:client/components/manage_exercise/exercise_dropdown.dart';
import 'package:client/components/shared/input_field.dart';
import 'package:client/models/exercise/exercise.dart';
import 'package:client/utils/validator.dart';
import 'package:client/view_models/manage_exercise_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ManageExercisePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ManageExerciseModel _model =
        Provider.of<ManageExerciseModel>(context, listen: false);

    return StreamBuilder<bool>(
      initialData: false,
      stream: _model.autovalidate,
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        bool _autovalidate = snapshot.data;

        return Form(
          key: _model.formKey,
          autovalidateMode: _autovalidate
              ? AutovalidateMode.always
              : AutovalidateMode.disabled,
          child: StreamBuilder<bool>(
            initialData: false,
            stream: _model.isLoading,
            builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
              bool _isLoading = snapshot.data;

              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: StreamBuilder<Exercise>(
                      stream: _model.exerciseStream,
                      builder: (BuildContext context,
                          AsyncSnapshot<Exercise> snapshot) {
                        if (snapshot.hasData) {
                          Exercise _exercise = snapshot.data;

                          print(_exercise);

                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              InputField(
                                labelText: 'Exercise Name',
                                controller: _model.nameController,
                                fillColor: Constants.secondElevation,
                                enabled: !_isLoading,
                                onSubmitted: (_) =>
                                    FocusScope.of(context).unfocus(),
                              ),
                              SizedBox(height: 20.0),
                              ExerciseDropdown(
                                hintText: 'Select Exercise Type',
                                items: Constants.exerciseTypes,
                                enabled: !_isLoading,
                                initialValue:
                                    _model.isEditMode ? _exercise.type : null,
                                onChanged: (String value) =>
                                    _model.setExerciseType(value),
                                validator: (String value) =>
                                    Validator.validateExerciseType(value),
                              ),
                              SizedBox(height: 20.0),
                              _exercise.type == Constants.lifting
                                  ? ExerciseDropdown(
                                      hintText: 'Select Body Part',
                                      items: Constants.bodyParts,
                                      enabled: !_isLoading,
                                      initialValue: _model.isEditMode
                                          ? _exercise.bodyPart
                                          : null,
                                      onChanged: (String value) =>
                                          _exercise.bodyPart = value,
                                      validator: (String value) =>
                                          Validator.validateBodyPart(
                                              value, _exercise.type),
                                    )
                                  : SizedBox.shrink(),
                            ],
                          );
                        }

                        return Container();
                      },
                    ),
                  ),
                  ActionButtons(
                    confirmText: _model.isEditMode
                        ? 'Update Exercise'
                        : 'Create Exercise',
                    color: Constants.secondElevation,
                    disabled: _isLoading,
                    onConfirmed: () => _saveExercise(context),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }

  void _saveExercise(BuildContext context) async {
    ManageExerciseModel _model =
        Provider.of<ManageExerciseModel>(context, listen: false);

    try {
      bool success = await _model.saveExercise();

      if (success) {
        Navigator.pop(context);
      }
    } catch (e) {
      AppError.show(context, e.message);
    }
  }
}
