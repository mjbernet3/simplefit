import 'package:client/app_style.dart';
import 'package:client/components/shared/small_input_field.dart';
import 'package:client/state_models/lift_form_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LiftSetRow extends StatelessWidget {
  final int index;
  final bool hintsOn;

  const LiftSetRow({
    this.index,
    this.hintsOn = false,
  });

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
            padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 30.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    _buildHint('Reps'),
                    SmallInputField(
                      onChanged: (String value) {
                        if (value.isNotEmpty) {
                          model.sets[index].reps = int.parse(value);
                        }
                      },
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    _buildHint('Weight'),
                    SmallInputField(
                      onChanged: (String value) {
                        if (value.isNotEmpty) {
                          model.sets[index].weight = int.parse(value);
                        }
                      },
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    _buildHint('Rest'),
                    SmallInputField(
                      onChanged: (String value) {
                        if (value.isNotEmpty) {
                          model.sets[index].reps = int.parse(value);
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
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
