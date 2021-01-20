import 'package:client/components/detail_exercise/lift_set_row.dart';
import 'package:client/components/shared/rounded_button.dart';
import 'package:client/models/exercise/lift_set.dart';
import 'package:client/view_models/detail_lift_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailLift extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DetailLiftModel model =
        Provider.of<DetailLiftModel>(context, listen: false);

    return StreamBuilder<List<LiftSet>>(
      stream: model.setsStream,
      builder: (BuildContext context, AsyncSnapshot<List<LiftSet>> snapshot) {
        if (snapshot.hasData) {
          List<LiftSet> sets = snapshot.data;

          return Column(
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

                  return LiftSetRow(
                    key: ObjectKey(currentSet),
                    set: currentSet,
                    setNumber: (index + 1).toString(),
                    onRemovePressed: () => model.removeSetAt(index),
                    hintsOn: index == 0 ? true : false,
                  );
                },
              ),
              SizedBox(height: 14.0),
              RoundedButton(
                buttonText: 'Add Set',
                height: 30.0,
                onPressed: () => model.addSet(),
              ),
            ],
          );
        }

        return Container();
      },
    );
  }
}
