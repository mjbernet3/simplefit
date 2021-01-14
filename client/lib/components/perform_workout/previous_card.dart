import 'package:client/utils/app_error.dart';
import 'package:client/utils/constants.dart';
import 'package:flutter/material.dart';

class PreviousCard extends StatelessWidget {
  final Map<String, Text> stats;

  const PreviousCard({
    @required this.stats,
  }) : assert(stats.length <= 3);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Container(
              color: Constants.firstElevation,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: _buildStats(),
              ),
            ),
          ),
          SizedBox(width: 10.0),
          GestureDetector(
            onTap: () =>
                AppError.show(context, "Exercise history is in development"),
            child: Container(
              color: Constants.firstElevation,
              padding: EdgeInsets.symmetric(horizontal: 15.0),
              child: Icon(Icons.history_rounded),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildStats() {
    List<Widget> children = stats.entries
        .map(
          (entry) => Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  entry.key,
                  style: TextStyle(
                    color: Constants.medEmphasis,
                  ),
                ),
                SizedBox(height: 10.0),
                entry.value,
              ],
            ),
          ),
        )
        .toList();

    return children;
  }
}