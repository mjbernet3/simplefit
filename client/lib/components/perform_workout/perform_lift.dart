import 'package:client/components/perform_workout/horizontal_stat_adjuster.dart';
import 'package:client/components/perform_workout/previous_card.dart';
import 'package:client/components/perform_workout/vertical_stat_adjuster.dart';
import 'package:client/components/shared/rounded_button.dart';
import 'package:client/models/exercise/lift_set.dart';
import 'package:client/models/exercise/weight_lift.dart';
import 'package:client/view_models/perform_lift_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PerformLift extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    PerformLiftModel _model =
        Provider.of<PerformLiftModel>(context, listen: false);

    return StreamBuilder<LiftSet>(
      stream: _model.setStream,
      builder: (BuildContext context, AsyncSnapshot<LiftSet> snapshot) {
        if (snapshot.hasData) {
          LiftSet _currentSet = snapshot.data;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Text(
                      "Set ${_model.setNumber}",
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
                  _model.hasNext()
                      ? RoundedButton(
                          height: 35.0,
                          buttonText: 'Next Set',
                          onPressed: () => _model.next(),
                        )
                      : SizedBox.shrink(),
                ],
              ),
              Divider(),
              PreviousCard(
                stats: {
                  'Weight': Text(_currentSet.weight.toString()),
                  'Reps':
                      Text('${_currentSet.reps} / ${_currentSet.targetReps}'),
                  'Advance': Text(_model.shouldAdvance ? 'Yes' : 'No'),
                },
              ),
              SizedBox(height: 10.0),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: VerticalStatAdjuster(
                        stat: _currentSet.weight.toDouble(),
                        unit: "Lbs",
                        adjustAmount: 1,
                        onChanged: (double value) =>
                            _currentSet.weight = value.toInt(),
                        displayPrecise: false,
                      ),
                    ),
                    SizedBox(width: 10.0),
                    Expanded(
                      child: VerticalStatAdjuster(
                        stat: _currentSet.reps.toDouble(),
                        unit: "Reps",
                        adjustAmount: 1,
                        onChanged: (double value) =>
                            _currentSet.reps = value.toInt(),
                        displayPrecise: false,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        }

        return Container();
      },
    );
  }
}
