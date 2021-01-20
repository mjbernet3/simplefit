import 'package:client/components/shared/app_icon_button.dart';
import 'package:client/utils/constants.dart';
import 'package:flutter/material.dart';

// TODO: Add max and min so stat does not adjust incorrectly
class HorizontalStatAdjuster extends StatefulWidget {
  final double stat;
  final String unit;
  final double adjustAmount;
  final Function onChanged;
  final bool displayPrecise;

  HorizontalStatAdjuster({
    this.stat,
    this.unit,
    this.adjustAmount,
    this.onChanged,
    this.displayPrecise = true,
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
  void didUpdateWidget(HorizontalStatAdjuster oldWidget) {
    if (_currentStat != widget.stat) {
      setState(() => _currentStat = widget.stat);
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Constants.firstElevation,
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            children: [
              Text(
                _currentStat.toStringAsFixed(widget.displayPrecise ? 1 : 0),
                style: TextStyle(fontSize: 36.0),
              ),
              SizedBox(width: 5.0),
              Text(
                widget.unit,
                style: TextStyle(color: Constants.medEmphasis),
              ),
            ],
          ),
          Row(
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
          )
        ],
      ),
    );
  }
}
