import 'package:client/components/detail_exercise/detail_distance.dart';
import 'package:client/components/detail_exercise/detail_lift.dart';
import 'package:client/components/detail_exercise/detail_timed.dart';
import 'package:client/components/detail_exercise/warm_up_check.dart';
import 'package:client/components/shared/action_buttons.dart';
import 'package:client/components/shared/app_divider.dart';
import 'package:client/components/shared/input_field.dart';
import 'package:client/models/exercise/exercise_data.dart';
import 'package:client/utils/app_style.dart';
import 'package:client/utils/constant.dart';
import 'package:client/view_models/detail_lift_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailExercisePage extends StatefulWidget {
  final ExerciseData exerciseData;

  const DetailExercisePage({this.exerciseData});

  @override
  _DetailExercisePageState createState() => _DetailExercisePageState();
}

class _DetailExercisePageState extends State<DetailExercisePage> {
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
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                widget.exerciseData.exercise.name,
                style: TextStyle(
                  color: AppStyle.highEmphasis,
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
                      color: AppStyle.medEmphasis,
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
              Expanded(
                child: _buildExerciseForm(),
              ),
              ActionButtons(
                onConfirmed: () => {
                  widget.exerciseData.notes = _notesController.text,
                  widget.exerciseData.isWarmUp = _isWarmUp,
                  Navigator.pop(context, widget.exerciseData),
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildExerciseForm() {
    String exerciseType = widget.exerciseData.exercise.type;

    switch (exerciseType) {
      case Constant.lifting:
        return Provider<DetailLiftModel>(
          create: (context) => DetailLiftModel(widget.exerciseData),
          dispose: (context, model) => model.dispose(),
          child: DetailLift(widget.exerciseData),
        );
      case Constant.timed:
        return DetailTimed(widget.exerciseData);
      case Constant.distance:
        return DetailDistance(widget.exerciseData);
      default:
        return Container();
    }
  }

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }
}
