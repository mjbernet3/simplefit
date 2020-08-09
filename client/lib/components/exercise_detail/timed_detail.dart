import 'package:client/app_style.dart';
import 'package:client/components/exercise_detail/base_detail.dart';
import 'package:client/components/exercise_detail/detail_card.dart';
import 'package:client/view_models/timed_detail_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TimedDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TimedDetailModel model =
        Provider.of<TimedDetailModel>(context, listen: false);
    return BaseDetail(
      exerciseData: model.timedData,
      warmUpCheck: StreamBuilder<bool>(
        stream: model.warmUpStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            bool isWarmUp = snapshot.data;

            return Checkbox(
              activeColor: AppStyle.primaryColor,
              checkColor: AppStyle.backgroundColor,
              value: isWarmUp,
              onChanged: (_) => model.toggleWarmUp(),
            );
          }

          return Container();
        },
      ),
      child: Expanded(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              DetailCard(
                text: 'Cardio Time:',
                initialValue: model.timedData.time.toString(),
                onChanged: (String value) =>
                    model.timedData.time = int.parse(value),
              ),
              DetailCard(
                text: 'Cardio Speed:',
                initialValue: model.timedData.speed.toString(),
                onChanged: (String value) =>
                    model.timedData.speed = double.parse(value),
              ),
              DetailCard(
                text: 'Post-Cardio Rest: ',
                initialValue: model.timedData.rest.toString(),
                onChanged: (String value) =>
                    model.timedData.rest = int.parse(value),
              ),
              DetailCard(
                text: 'Times to Repeat:',
                initialValue: model.timedData.repeat.toString(),
                onChanged: (String value) =>
                    model.timedData.repeat = int.parse(value),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
