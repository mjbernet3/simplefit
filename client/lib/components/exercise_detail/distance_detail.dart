import 'package:client/app_style.dart';
import 'package:client/components/exercise_detail/base_detail.dart';
import 'package:client/components/exercise_detail/detail_card.dart';
import 'package:client/view_models/distance_detail_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DistanceDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DistanceDetailModel model =
        Provider.of<DistanceDetailModel>(context, listen: false);
    return BaseDetail(
      exerciseData: model.distanceData,
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
                text: 'Cardio Distance:',
                initialValue: model.distanceData.distance.toString(),
                onChanged: (String value) =>
                    model.distanceData.distance = double.parse(value),
              ),
              DetailCard(
                text: 'Cardio Speed:',
                initialValue: model.distanceData.speed.toString(),
                onChanged: (String value) =>
                    model.distanceData.speed = double.parse(value),
              ),
              DetailCard(
                text: 'Post-Cardio Rest: ',
                initialValue: model.distanceData.rest.toString(),
                onChanged: (String value) =>
                    model.distanceData.rest = int.parse(value),
              ),
              DetailCard(
                text: 'Times to Repeat:',
                initialValue: model.distanceData.repeat.toString(),
                onChanged: (String value) =>
                    model.distanceData.repeat = int.parse(value),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
