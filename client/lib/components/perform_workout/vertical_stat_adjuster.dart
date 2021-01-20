import 'package:client/components/shared/app_icon_button.dart';
import 'package:client/utils/constants.dart';
import 'package:flutter/material.dart';

class VerticalStatAdjuster extends StatefulWidget {
  final double stat;
  final String unit;
  final double adjustAmount;
  final Function onChanged;
  final bool displayPrecise;

  VerticalStatAdjuster({
    this.stat,
    this.unit,
    this.adjustAmount,
    this.onChanged,
    this.displayPrecise = true,
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
      color: Constants.firstElevation,
      child: Column(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 30.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _currentStat.toStringAsFixed(widget.displayPrecise ? 1 : 0),
                    style: TextStyle(fontSize: 36.0),
                  ),
                  SizedBox(height: 5.0),
                  Text(
                    widget.unit,
                    style: TextStyle(color: Constants.medEmphasis),
                  ),
                ],
              ),
            ),
          ),
          Divider(),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppIconButton(
                  icon: Icon(Icons.remove),
                  padding: EdgeInsets.all(4.0),
                  color: Constants.secondElevation,
                  onPressed: () => {
                    setState(() => _currentStat -= widget.adjustAmount),
                    widget.onChanged(_currentStat),
                  },
                ),
                SizedBox(width: 10.0),
                AppIconButton(
                  icon: Icon(Icons.add),
                  padding: EdgeInsets.all(4.0),
                  color: Constants.secondElevation,
                  onPressed: () => {
                    setState(() => _currentStat += widget.adjustAmount),
                    widget.onChanged(_currentStat),
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
