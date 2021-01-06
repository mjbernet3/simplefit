import 'package:client/components/shared/app_divider.dart';
import 'package:client/utils/app_style.dart';
import 'package:flutter/material.dart';

class StatAdjuster extends StatefulWidget {
  final double stat;
  final String unit;
  final double adjustAmount;
  final Function onIncrement;
  final Function onDecrement;

  StatAdjuster({
    this.stat,
    this.unit,
    this.adjustAmount,
    this.onIncrement,
    this.onDecrement,
  });

  @override
  _StatAdjusterState createState() => _StatAdjusterState();
}

class _StatAdjusterState extends State<StatAdjuster> {
  double _currentStat;

  @override
  void initState() {
    super.initState();
    _currentStat = widget.stat;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppStyle.dp4,
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
                      fontSize: 36.0,
                    ),
                  ),
                  SizedBox(height: 5.0),
                  Text(
                    widget.unit,
                    style: TextStyle(color: AppStyle.medEmphasisText),
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
                  fillColor: AppStyle.dp12,
                  shape: CircleBorder(),
                  child: Icon(Icons.remove),
                  onPressed: () => setState(
                    () => {
                      _currentStat -= widget.adjustAmount,
                      widget.onDecrement(),
                    },
                  ),
                ),
                RawMaterialButton(
                  constraints: BoxConstraints(
                    minWidth: 0.0,
                  ),
                  padding: EdgeInsets.all(8.0),
                  fillColor: AppStyle.dp12,
                  shape: CircleBorder(),
                  child: Icon(Icons.add),
                  onPressed: () => setState(
                    () => {
                      _currentStat += widget.adjustAmount,
                      widget.onIncrement(),
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
