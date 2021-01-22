import 'package:client/utils/constants.dart';
import 'package:client/components/shared/number_input_field.dart';
import 'package:client/models/exercise/lift_set.dart';
import 'package:flutter/material.dart';

enum PopupChoice {
  WARM_UP,
  REMOVE,
}

class LiftSetRow extends StatelessWidget {
  final LiftSet set;
  final String setNumber;
  final Function onRemovePressed;
  final bool hintsOn;

  LiftSetRow({
    @required Key key,
    @required this.set,
    @required this.setNumber,
    this.onRemovePressed,
    this.hintsOn = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Column(
          children: <Widget>[
            _buildHint('Set'),
            Container(
              height: 30.0,
              width: 30.0,
              decoration: const BoxDecoration(
                color: Constants.firstElevation,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(setNumber),
              ),
            ),
          ],
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    _buildHint('Reps'),
                    NumberInputField(
                      initialValue: set.targetReps.toString(),
                      onChanged: (String value) =>
                          set.targetReps = int.parse(value),
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    _buildHint('Weight'),
                    NumberInputField(
                      initialValue: set.weight.toString(),
                      onChanged: (String value) =>
                          set.weight = int.parse(value),
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    _buildHint('Rest'),
                    NumberInputField(
                      initialValue: set.rest.toString(),
                      onChanged: (String value) => set.rest = int.parse(value),
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
            PopupMenuButton<PopupChoice>(
              icon: const Icon(Icons.more_vert),
              color: Constants.secondElevation,
              onSelected: (PopupChoice choice) =>
                  _handleChoice(context, choice),
              itemBuilder: (BuildContext context) =>
                  <PopupMenuEntry<PopupChoice>>[
                PopupMenuItem<PopupChoice>(
                  value: PopupChoice.WARM_UP,
                  child: Row(
                    children: <Widget>[
                      const Text('Warm up set'),
                      set.isWarmUp
                          ? Row(
                              children: <Widget>[
                                const SizedBox(width: 5.0),
                                const Icon(Icons.check),
                              ],
                            )
                          : const SizedBox.shrink(),
                    ],
                  ),
                ),
                const PopupMenuItem<PopupChoice>(
                  value: PopupChoice.REMOVE,
                  child: Text('Remove this set'),
                ),
              ],
            ),
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
              const SizedBox(height: 10.0),
            ],
          )
        : const SizedBox.shrink();
  }

  void _handleChoice(BuildContext context, PopupChoice choice) {
    switch (choice) {
      case PopupChoice.WARM_UP:
        set.isWarmUp = !set.isWarmUp;
        break;
      case PopupChoice.REMOVE:
        onRemovePressed();
        break;
      default:
        break;
    }
  }
}
