import 'package:client/app_style.dart';
import 'package:client/components/shared/app_divider.dart';
import 'package:client/components/shared/input_field.dart';
import 'package:client/components/shared/rounded_button.dart';
import 'package:client/models/exercise/exercise_data.dart';
import 'package:flutter/material.dart';

class BaseDetail extends StatefulWidget {
  final ExerciseData exerciseData;
  final StreamBuilder<bool> warmUpCheck;
  final Widget child;

  BaseDetail({
    this.exerciseData,
    this.warmUpCheck,
    this.child,
  });

  @override
  _BaseDetailState createState() => _BaseDetailState();
}

class _BaseDetailState extends State<BaseDetail> {
  TextEditingController _notesController;

  @override
  void initState() {
    super.initState();
    _notesController = TextEditingController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _notesController.text = widget.exerciseData.notes;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          widget.exerciseData.exercise.name,
          style: TextStyle(
            fontSize: 24.0,
          ),
        ),
        SizedBox(height: 14.0),
        InputField(
          controller: _notesController,
          hintText: 'Notes...',
          keyboardType: TextInputType.multiline,
          textInputAction: TextInputAction.newline,
          maxLines: null,
        ),
        SizedBox(height: 20.0),
        Row(
          children: <Widget>[
            Text(
              'Warm-up Exercise',
              style: TextStyle(
                color: AppStyle.medEmphasisText,
                fontSize: 14.0,
              ),
            ),
            SizedBox(width: 10.0),
            SizedBox(
              height: 15.0,
              width: 15.0,
              child: widget.warmUpCheck,
            ),
          ],
        ),
        SizedBox(height: 14.0),
        AppDivider(),
        SizedBox(height: 14.0),
        widget.child,
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
                    'Save Changes',
                    style: TextStyle(color: AppStyle.highEmphasisText),
                  ),
                  height: 30.0,
                  color: AppStyle.dp4,
                  borderColor: AppStyle.dp4,
                  onPressed: () => {
                    widget.exerciseData.notes = _notesController.text,
                    Navigator.pop(context, widget.exerciseData),
                  },
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }
}
