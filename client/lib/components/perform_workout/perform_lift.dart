import 'package:client/components/perform_workout/horizontal_stat_adjuster.dart';
import 'package:client/components/perform_workout/previous_card.dart';
import 'package:client/components/shared/app_divider.dart';
import 'package:client/components/shared/rounded_button.dart';
import 'package:client/models/exercise/lift_set.dart';
import 'package:client/models/exercise/weight_lift.dart';
import 'package:client/utils/app_style.dart';
import 'package:flutter/material.dart';

class PerformLift extends StatefulWidget {
  final WeightLift exercise;

  PerformLift({this.exercise});

  @override
  _PerformLiftState createState() => _PerformLiftState();
}

class _PerformLiftState extends State<PerformLift> {
  LiftSet _currentSet;
  int _index = 0;

  @override
  void initState() {
    super.initState();
    _currentSet = widget.exercise.sets[_index];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.only(left: 8.0),
              child: Text(
                "Set ${_index + 1}",
                style: TextStyle(
                  color: AppStyle.highEmphasis,
                  fontSize: 20.0,
                ),
              ),
            ),
            _hasNextSet()
                ? RoundedButton(
                    height: 35.0,
                    buttonText: Text("Next Set"),
                    onPressed: _nextSet,
                  )
                : SizedBox.shrink(),
          ],
        ),
        AppDivider(),
        PreviousCard(
          stats: {
            'Weight': Text(
              _currentSet.weight.toString(),
              style: TextStyle(color: AppStyle.highEmphasis),
            ),
            'Reps': Text(
              '${_currentSet.reps} / ${_currentSet.targetReps}',
              style: TextStyle(color: AppStyle.highEmphasis),
            ),
            'Advance': Text(
              widget.exercise.shouldAdvance ? 'Yes' : 'No',
              style: TextStyle(color: AppStyle.highEmphasis),
            ),
          },
        ),
        SizedBox(height: 10.0),
        Expanded(
          child: Column(
            children: [
              Expanded(
                child: HorizontalStatAdjuster(
                  stat: _currentSet.weight.toDouble(),
                  unit: "Lbs",
                  adjustAmount: 1,
                  onChanged: (double value) =>
                      _currentSet.weight = value.toInt(),
                  displayPrecise: false,
                ),
              ),
              SizedBox(height: 10.0),
              Expanded(
                child: HorizontalStatAdjuster(
                  stat: _currentSet.reps.toDouble(),
                  unit: "Reps",
                  adjustAmount: 1,
                  onChanged: (double value) => _currentSet.reps = value.toInt(),
                  displayPrecise: false,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  bool _hasNextSet() {
    return _index < widget.exercise.sets.length - 1;
  }

  void _nextSet() {
    if (_hasNextSet()) {
      setState(
        () => {
          _index++,
          _currentSet = widget.exercise.sets[_index],
        },
      );
    }
  }
}
