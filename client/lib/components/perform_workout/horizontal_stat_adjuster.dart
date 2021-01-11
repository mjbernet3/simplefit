import 'package:client/utils/app_style.dart';
import 'package:flutter/material.dart';

class HorizontalStatAdjuster extends StatefulWidget {
  final double stat;
  final String unit;
  final double adjustAmount;
  final Function onChanged;

  const HorizontalStatAdjuster({
    this.stat,
    this.unit,
    this.adjustAmount,
    this.onChanged,
  });

  @override
  _HorizontalStatAdjusterState createState() => _HorizontalStatAdjusterState();
}

class _HorizontalStatAdjusterState extends State<HorizontalStatAdjuster> {
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
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              children: [
                Text(
                  _currentStat.toStringAsFixed(1),
                  style: TextStyle(
                    color: AppStyle.highEmphasis,
                    fontSize: 36.0,
                  ),
                ),
                SizedBox(width: 5.0),
                Text(
                  widget.unit,
                  style: TextStyle(color: AppStyle.medEmphasis),
                ),
              ],
            ),
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () => {
                  setState(() => _currentStat -= widget.adjustAmount),
                  widget.onChanged(_currentStat),
                },
                child: Container(
                  padding: EdgeInsets.all(4.0),
                  decoration: BoxDecoration(
                    color: AppStyle.secondElevation,
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: Icon(
                    Icons.remove,
                    color: AppStyle.highEmphasis,
                  ),
                ),
              ),
              SizedBox(width: 10.0),
              GestureDetector(
                onTap: () => {
                  setState(() => _currentStat += widget.adjustAmount),
                  widget.onChanged(_currentStat),
                },
                child: Container(
                  padding: EdgeInsets.all(4.0),
                  decoration: BoxDecoration(
                    color: AppStyle.secondElevation,
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: Icon(
                    Icons.add,
                    color: AppStyle.highEmphasis,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
