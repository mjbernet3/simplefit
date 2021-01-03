import 'package:client/components/exercise_detail/detail_distance.dart';
import 'package:client/components/exercise_detail/detail_lift.dart';
import 'package:client/components/exercise_detail/detail_timed.dart';
import 'package:client/components/exercise_detail/warm_up_check.dart';
import 'package:client/components/shared/action_buttons.dart';
import 'package:client/components/shared/app_divider.dart';
import 'package:client/components/shared/input_field.dart';
import 'package:client/models/exercise/distance_cardio.dart';
import 'package:client/models/exercise/exercise_data.dart';
import 'package:client/models/exercise/timed_cardio.dart';
import 'package:client/models/exercise/weight_lift.dart';
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
        WeightLift liftData = WeightLift.copy(widget.exerciseData);
        return Provider<DetailLiftModel>(
          create: (context) => DetailLiftModel(liftData),
          dispose: (context, model) => model.dispose(),
          child: DetailLift(liftData),
        );
      case Constant.timed:
        TimedCardio timedData = TimedCardio.copy(widget.exerciseData);
        return DetailTimed(timedData);
      case Constant.distance:
        DistanceCardio distanceData = DistanceCardio.copy(widget.exerciseData);
        return DetailDistance(distanceData);
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
