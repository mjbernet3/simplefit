import 'package:client/app_style.dart';
import 'package:client/components/shared/exercise_browser.dart';
import 'package:client/components/shared/input_field.dart';
import 'package:flutter/material.dart';

class CreateWorkoutBody extends StatefulWidget {
  @override
  _CreateWorkoutBodyState createState() => _CreateWorkoutBodyState();
}

class _CreateWorkoutBodyState extends State<CreateWorkoutBody> {
  TextEditingController _nameController;
  TextEditingController _descriptionController;
  TextEditingController _notesController;

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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Exercises',
                style: TextStyle(
                  fontSize: 18.0,
                  color: AppStyle.highEmphasisText,
                ),
              ),
              GestureDetector(
                onTap: () => _openExercises(),
                child: Container(
                  padding: EdgeInsets.all(2.0),
                  decoration: BoxDecoration(
                    color: AppStyle.dp2,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.add),
                ),
              ),
            ],
          ),
        ),
        Divider(
          thickness: 1.5,
          color: AppStyle.dp24,
        ),
//        RoundedButton(
//          buttonText: Text(
//            'Add Exercise',
//            style: TextStyle(color: AppStyle.highEmphasisText),
//          ),
//          height: 30.0,
//          color: AppStyle.dp4,
//          borderColor: AppStyle.dp4,
//          onPressed: () => print('hello'),
//        ),
//        InputField(
//          controller: _notesController,
//          labelText: 'Notes',
//          keyboardType: TextInputType.multiline,
//          textInputAction: TextInputAction.newline,
//          maxLines: null,
//        ),
      ],
    );
  }

  void _openExercises() {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return ExerciseBrowser();
      },
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
