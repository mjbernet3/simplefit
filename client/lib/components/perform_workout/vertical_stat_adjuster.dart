import 'package:client/components/shared/app_divider.dart';
import 'package:client/utils/app_style.dart';
import 'package:flutter/material.dart';

class VerticalStatAdjuster extends StatefulWidget {
  final double stat;
  final String unit;
  final double adjustAmount;
  final Function onChanged;

  VerticalStatAdjuster({
    this.stat,
    this.unit,
    this.adjustAmount,
    this.onChanged,
  });

  @override
  _VerticalStatAdjusterState createState() => _VerticalStatAdjusterState();
}

class _VerticalStatAdjusterState extends State<VerticalStatAdjuster> {
  double _currentStat;

  @override
  void initState() {
    super.initState();
    _currentStat = widget.stat;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppStyle.firstElevation,
      child: Column(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 30.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _currentStat.toStringAsFixed(1),
                    style: TextStyle(
                      color: AppStyle.highEmphasis,
                      fontSize: 36.0,
                    ),
                  ),
                  SizedBox(height: 5.0),
                  Text(
                    widget.unit,
                    style: TextStyle(color: AppStyle.medEmphasis),
                  ),
                ],
              ),
            ),
          ),
          AppDivider(),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                RawMaterialButton(
                  constraints: BoxConstraints(
                    minWidth: 0.0,
                  ),
                  padding: EdgeInsets.all(8.0),
                  fillColor: AppStyle.secondElevation,
                  shape: CircleBorder(),
                  child: Icon(
                    Icons.remove,
                    color: AppStyle.highEmphasis,
                  ),
                  onPressed: () => setState(
                    () => {
                      _currentStat -= widget.adjustAmount,
                      widget.onChanged(_currentStat),
                    },
                  ),
                ),
                RawMaterialButton(
                  constraints: BoxConstraints(
                    minWidth: 0.0,
                  ),
                  padding: EdgeInsets.all(8.0),
                  fillColor: AppStyle.secondElevation,
                  shape: CircleBorder(),
                  child: Icon(
                    Icons.add,
                    color: AppStyle.highEmphasis,
                  ),
                  onPressed: () => setState(
                    () => {
                      _currentStat += widget.adjustAmount,
                      widget.onChanged(_currentStat),
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
