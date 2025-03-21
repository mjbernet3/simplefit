import 'package:client/components/shared/removable_card.dart';
import 'package:client/models/workout/workout_preview.dart';
import 'package:client/utils/constants.dart';
import 'package:flutter/material.dart';

class PreviewCard extends StatelessWidget {
  final WorkoutPreview workoutPreview;
  final GestureTapCallback onPressed;
  final GestureTapCallback onRemovePressed;
  final bool isEditing;

  PreviewCard({
    required Key key,
    required this.workoutPreview,
    required this.onPressed,
    required this.onRemovePressed,
    this.isEditing = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RemovableCard(
      onPressed: onPressed,
      onRemovePressed: onRemovePressed,
      isRemovable: isEditing,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              workoutPreview.name,
              style: const TextStyle(fontSize: 16.0),
              maxLines: 1,
              softWrap: false,
              overflow: TextOverflow.fade,
            ),
            isEditing
                ? const Icon(
                    Icons.reorder,
                    color: Constants.lowEmphasis,
                    size: 20.0,
                  )
                : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
