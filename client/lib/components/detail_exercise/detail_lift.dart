import 'package:client/components/detail_exercise/lift_set_row.dart';
import 'package:client/utils/app_style.dart';
import 'package:client/components/shared/rounded_button.dart';
import 'package:client/models/exercise/lift_set.dart';
import 'package:client/models/exercise/weight_lift.dart';
import 'package:client/view_models/detail_lift_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailLift extends StatelessWidget {
  final WeightLift liftData;

  const DetailLift(this.liftData);

  @override
  Widget build(BuildContext context) {
    DetailLiftModel model =
        Provider.of<DetailLiftModel>(context, listen: false);
    return StreamBuilder<List<LiftSet>>(
      stream: model.setStream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<LiftSet> sets = snapshot.data;

          return ListView(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: sets.length,
                    separatorBuilder: (BuildContext context, int index) =>
                        SizedBox(height: 4.0),
                    itemBuilder: (BuildContext context, int index) {
                      LiftSet currentSet = sets[index];

                      if (index == 0) {
                        return LiftSetRow(
                          key: ObjectKey(currentSet),
                          index: index,
                          hintsOn: true,
                        );
                      }

                      return LiftSetRow(
                        key: ObjectKey(currentSet),
                        index: index,
                      );
                    },
                  ),
                  SizedBox(height: 14.0),
                  RoundedButton(
                    buttonText: Text(
                      'Add Set',
                      style: TextStyle(
                        color: AppStyle.highEmphasisText,
                      ),
                    ),
                    height: 30.0,
                    color: AppStyle.dp4,
                    borderColor: AppStyle.dp4,
                    onPressed: () => model.addSet(),
                  ),
                ],
              ),
            ],
          );
        }

        return Container();
      },
    );
  }
}
