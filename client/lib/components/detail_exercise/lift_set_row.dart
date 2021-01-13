import 'package:client/components/detail_exercise/set_options.dart';
import 'package:client/utils/constants.dart';
import 'package:client/components/shared/small_input_field.dart';
import 'package:client/models/exercise/lift_set.dart';
import 'package:client/view_models/detail_lift_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LiftSetRow extends StatelessWidget {
  final int index;
  final bool hintsOn;

  const LiftSetRow({
    Key key,
    this.index,
    this.hintsOn = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DetailLiftModel model =
        Provider.of<DetailLiftModel>(context, listen: false);
    List<LiftSet> sets = model.getSets();

    return Row(
      children: <Widget>[
        Column(
          children: <Widget>[
            _buildHint('Set'),
            Container(
              height: 30.0,
              width: 30.0,
              decoration: BoxDecoration(
                color: Constants.firstElevation,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  (index + 1).toString(),
                  style: TextStyle(),
                ),
              ),
            ),
          ],
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(left: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    _buildHint('Reps'),
                    SmallInputField(
                      initialValue: sets[index].targetReps.toString(),
                      onChanged: (String value) {
                        if (value.isNotEmpty) {
                          sets[index].targetReps = int.parse(value);
                        }
                      },
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    _buildHint('Weight'),
                    SmallInputField(
                      initialValue: sets[index].weight.toString(),
                      onChanged: (String value) {
                        if (value.isNotEmpty) {
                          sets[index].weight = int.parse(value);
                        }
                      },
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    _buildHint('Rest'),
                    SmallInputField(
                      initialValue: sets[index].rest.toString(),
                      onChanged: (String value) {
                        if (value.isNotEmpty) {
                          sets[index].rest = int.parse(value);
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Column(
          children: <Widget>[
            _buildHint(''),
            SetOptions(index: index),
          ],
        ),
      ],
    );
  }

  Widget _buildHint(String hintText) {
    return hintsOn
        ? Column(
            children: <Widget>[
              Text(hintText),
              SizedBox(height: 10.0),
            ],
          )
        : SizedBox.shrink();
  }
}
