import 'package:client/app_style.dart';
import 'package:client/components/exercise_detail/warm_up_check.dart';
import 'package:client/components/shared/action_buttons.dart';
import 'package:client/components/shared/app_divider.dart';
import 'package:client/components/shared/input_field.dart';
import 'package:client/models/exercise/exercise_data.dart';
import 'package:flutter/material.dart';

class BaseDetail extends StatefulWidget {
  final ExerciseData exerciseData;
  final Widget child;

  BaseDetail({
    this.exerciseData,
    this.child,
  });

  @override
  _BaseDetailState createState() => _BaseDetailState();
}

class _BaseDetailState extends State<BaseDetail> {
  TextEditingController _notesController;
  bool _isWarmUp;

  @override
  void initState() {
    super.initState();
    _notesController = TextEditingController();
    _notesController.text = widget.exerciseData.notes;
    _isWarmUp = widget.exerciseData.isWarmUp;
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
              child: WarmUpCheck(
                initialValue: _isWarmUp,
                onChanged: (value) => _isWarmUp = value,
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        AppDivider(),
        SizedBox(height: 14.0),
        widget.child,
        ActionButtons(
          onConfirmed: () => {
            widget.exerciseData.notes = _notesController.text,
            widget.exerciseData.isWarmUp = _isWarmUp,
            Navigator.pop(context, widget.exerciseData),
          },
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
