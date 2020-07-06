import 'package:client/app_style.dart';
import 'package:client/components/shared/app_divider.dart';
import 'package:client/components/shared/input_field.dart';
import 'package:client/components/shared/rounded_button.dart';
import 'package:client/models/exercise/exercise.dart';
import 'package:client/router.dart';
import 'package:flutter/material.dart';

class CreateWorkoutBody extends StatefulWidget {
  @override
  _CreateWorkoutBodyState createState() => _CreateWorkoutBodyState();
}

class _CreateWorkoutBodyState extends State<CreateWorkoutBody> {
  TextEditingController _nameController;
  TextEditingController _descriptionController;
  TextEditingController _notesController;
  List<Exercise> exercises = [];

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _descriptionController = TextEditingController();
    _notesController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        InputField(
          controller: _nameController,
          labelText: 'Workout Name',
          onSubmitted: (_) => FocusScope.of(context).nextFocus(),
        ),
        SizedBox(height: 12.0),
        InputField(
          controller: _descriptionController,
          labelText: 'Workout Description',
          onSubmitted: (_) => FocusScope.of(context).unfocus(),
        ),
        SizedBox(height: 24.0),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
          child: Text(
            'Exercises',
            style: TextStyle(
              fontSize: 18.0,
              color: AppStyle.highEmphasisText,
            ),
          ),
        ),
        AppDivider(),
        ListView.builder(
          shrinkWrap: true,
          itemCount: exercises.length,
          itemBuilder: (BuildContext context, int index) {
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
          onPressed: () => Navigator.pushNamed(context, Router.browser),
        ),
        SizedBox(height: 24.0),
//        InputField(
//          controller: _notesController,
//          keyboardType: TextInputType.multiline,
//          textInputAction: TextInputAction.newline,
//          maxLines: null,
//        ),
      ],
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _notesController.dispose();
    super.dispose();
  }
}
