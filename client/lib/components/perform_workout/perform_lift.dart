import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:client/components/perform_workout/previous_card.dart';
import 'package:client/components/shared/info_tag.dart';
import 'package:client/components/shared/vertical_stat_adjuster.dart';
import 'package:client/components/shared/rounded_button.dart';
import 'package:client/models/exercise/lift_set.dart';
import 'package:client/utils/constants.dart';
import 'package:client/view_models/perform_lift_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PerformLift extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    PerformLiftModel model =
        Provider.of<PerformLiftModel>(context, listen: false);

    return StreamBuilder<LiftSet>(
      stream: model.set,
      builder: (BuildContext context, AsyncSnapshot<LiftSet> snapshot) {
        if (snapshot.hasData) {
          LiftSet currentSet = snapshot.data;

          return StreamBuilder<bool>(
            initialData: false,
            stream: model.isResting,
            builder: (context, snapshot) {
              bool isResting = snapshot.data;

              if (isResting) {
                return Column(
                  children: [
                    Expanded(
                      child: CircularCountDownTimer(
                        isReverse: true,
                        isReverseAnimation: true,
                        width: MediaQuery.of(context).size.width * 0.75,
                        height: MediaQuery.of(context).size.height,
                        duration: currentSet.rest,
                        fillColor: Constants.primaryColor,
                        color: Constants.firstElevation,
                        strokeWidth: 15.0,
                        textStyle: const TextStyle(fontSize: 40.0),
                        strokeCap: StrokeCap.round,
                        onComplete: () => model.next(),
                      ),
                    ),
                    RoundedButton(
                      height: 35.0,
                      buttonText: 'Skip Set Rest',
                      onPressed: () => model.next(),
                    ),
                  ],
                );
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              "Set ${model.setNumber}",
                              style: const TextStyle(fontSize: 20.0),
                            ),
                          ),
                          const SizedBox(width: 15.0),
                          currentSet.isWarmUp
                              ? InfoTag(infoText: 'Warm Up')
                              : const SizedBox.shrink(),
                        ],
                      ),
                      Visibility(
                        visible: model.hasNext(),
                        maintainSize: true,
                        maintainAnimation: true,
                        maintainState: true,
                        child: RoundedButton(
                          height: 35.0,
                          buttonText: 'Next Set',
                          onPressed: () => model.next(),
                        ),
                      ),
                    ],
                  ),
                  const Divider(),
                  Expanded(
                    child: Column(
                      children: [
                        PreviousCard(
                          stats: {
                            'Weight': Text(currentSet.weight.toString()),
                            'Reps': Text(
                                '${currentSet.reps} / ${currentSet.targetReps}'),
                            'Advance': Text(model.shouldAdvance ? 'Yes' : 'No'),
                          },
                        ),
                        const SizedBox(height: 10.0),
                        Expanded(
                          child: Row(
                            children: [
                              Expanded(
                                child: VerticalStatAdjuster(
                                  stat: currentSet.weight.toDouble(),
                                  maxStat:
                                      Constants.maxExerciseWeight.toDouble(),
                                  unit: "Lbs",
                                  adjustAmount: 1,
                                  onChanged: (double value) =>
                                      currentSet.weight = value.toInt(),
                                  displayPrecise: false,
                                ),
                              ),
                              const SizedBox(width: 10.0),
                              Expanded(
                                child: VerticalStatAdjuster(
                                  stat: currentSet.reps.toDouble(),
                                  maxStat: currentSet.targetReps.toDouble(),
                                  unit: "Reps",
                                  adjustAmount: 1,
                                  onChanged: (double value) =>
                                      currentSet.reps = value.toInt(),
                                  displayPrecise: false,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
