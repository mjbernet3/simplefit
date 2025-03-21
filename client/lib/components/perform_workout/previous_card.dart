import 'package:client/components/shared/app_icon_button.dart';
import 'package:client/utils/app_error.dart';
import 'package:client/utils/constants.dart';
import 'package:flutter/material.dart';

class PreviousCard extends StatelessWidget {
  final Map<String, Text> stats;

  PreviousCard({required this.stats}) : assert(stats.length <= 3);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Card(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: _buildStats(),
              ),
            ),
          ),
          const SizedBox(width: 10.0),
          AppIconButton(
            icon: const Icon(Icons.history_rounded),
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            onPressed: () =>
                AppError.show(context, "Exercise history is in development"),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildStats() {
    List<Widget> children = stats.entries
        .map(
          (entry) => Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  entry.key,
                  style: const TextStyle(
                    color: Constants.medEmphasis,
                  ),
                ),
                const SizedBox(height: 10.0),
                entry.value,
              ],
            ),
          ),
        )
        .toList();

    return children;
  }
}
