import 'package:client/app_style.dart';
import 'package:client/components/exercise_detail/set_options.dart';
import 'package:client/components/shared/small_input_field.dart';
import 'package:client/view_models/lift_form_model.dart';
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
    LiftFormModel model = Provider.of<LiftFormModel>(context, listen: false);

    return Row(
      children: <Widget>[
        Column(
          children: <Widget>[
            _buildHint('Set'),
            Container(
              height: 30.0,
              width: 30.0,
              decoration: BoxDecoration(
                color: AppStyle.dp8,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  (index + 1).toString(),
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
                      initialValue: model.workingSets[index].reps.toString(),
                      onChanged: (String value) {
                        if (value.isNotEmpty) {
                          model.workingSets[index].reps = int.parse(value);
                        }
                      },
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    _buildHint('Weight'),
                    SmallInputField(
                      initialValue: model.workingSets[index].weight.toString(),
                      onChanged: (String value) {
                        if (value.isNotEmpty) {
                          model.workingSets[index].weight = int.parse(value);
                        }
                      },
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    _buildHint('Rest'),
                    SmallInputField(
                      initialValue: model.workingSets[index].rest.toString(),
                      onChanged: (String value) {
                        if (value.isNotEmpty) {
                          model.workingSets[index].rest = int.parse(value);
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
              Text(
                hintText,
                style: TextStyle(
                  color: AppStyle.highEmphasisText,
                ),
              ),
              SizedBox(height: 10.0),
            ],
          )
        : SizedBox.shrink();
  }
}
