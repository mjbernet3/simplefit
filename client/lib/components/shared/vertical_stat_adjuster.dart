import 'package:client/components/shared/app_icon_button.dart';
import 'package:client/utils/constants.dart';
import 'package:flutter/material.dart';

class VerticalStatAdjuster extends StatefulWidget {
  final double stat;
  final double maxStat;
  final String unit;
  final double adjustAmount;
  final Function onChanged;
  final bool displayPrecise;

  VerticalStatAdjuster({
    @required this.stat,
    @required this.maxStat,
    @required this.unit,
    @required this.adjustAmount,
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
    _currentStat = widget.stat;
    super.initState();
  }

  @override
  void didUpdateWidget(VerticalStatAdjuster oldWidget) {
    if (_currentStat != widget.stat) {
      setState(() => _currentStat = widget.stat);
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 30.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _currentStat.toStringAsFixed(widget.displayPrecise ? 1 : 0),
                    style: const TextStyle(fontSize: 36.0),
                  ),
                  const SizedBox(height: 5.0),
                  Text(
                    widget.unit,
                    style: const TextStyle(color: Constants.medEmphasis),
                  ),
                ],
              ),
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppIconButton(
                  icon: const Icon(Icons.remove),
                  padding: const EdgeInsets.all(4.0),
                  color: Constants.secondElevation,
                  onPressed: _decrement,
                ),
                const SizedBox(width: 10.0),
                AppIconButton(
                  icon: const Icon(Icons.add),
                  padding: const EdgeInsets.all(4.0),
                  color: Constants.secondElevation,
                  onPressed: _increment,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _increment() {
    if (_currentStat + widget.adjustAmount <= widget.maxStat) {
      setState(() => _currentStat += widget.adjustAmount);
      widget.onChanged(_currentStat);
    }
  }

  void _decrement() {
    if (_currentStat - widget.adjustAmount >= 0) {
      setState(() => _currentStat -= widget.adjustAmount);
      widget.onChanged(_currentStat);
    }
  }
}
