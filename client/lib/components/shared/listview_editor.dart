import 'package:client/components/shared/app_icon_button.dart';
import 'package:client/utils/constants.dart';
import 'package:flutter/material.dart';

class ListViewEditor extends StatelessWidget {
  final String title;
  final ListView listView;
  final bool isEditing;
  final VoidCallback onEdit;
  final VoidCallback onAdd;
  final Color elevationColor;

  ListViewEditor({
    required this.title,
    required this.listView,
    required this.isEditing,
    required this.onEdit,
    required this.onAdd,
    this.elevationColor = Constants.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(fontSize: 18.0),
              ),
              Row(
                children: <Widget>[
                  AppIconButton(
                    icon: !isEditing
                        ? const Icon(
                            Icons.edit,
                            size: 24.0,
                          )
                        : const Icon(Icons.check),
                    color: elevationColor,
                    elevation: 0.0,
                    onPressed: onEdit,
                  ),
                  const SizedBox(height: 24.0, width: 8.0),
                  !isEditing
                      ? AppIconButton(
                          icon: const Icon(Icons.add),
                          color: elevationColor,
                          elevation: 0.0,
                          onPressed: onAdd,
                        )
                      : const SizedBox.shrink(),
                ],
              ),
            ],
          ),
        ),
        const Divider(),
        Expanded(
          child: listView,
        ),
      ],
    );
  }
}
