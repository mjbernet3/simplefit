import 'package:client/components/shared/app_icon_button.dart';
import 'package:client/utils/constants.dart';
import 'package:flutter/material.dart';

class ListViewEditor extends StatelessWidget {
  final String title;
  final ListView listView;
  final bool isEditing;
  final Function onEdit;
  final Function onAdd;
  final Color elevationColor;

  ListViewEditor({
    @required this.title,
    @required this.listView,
    @required this.isEditing,
    this.onEdit,
    this.onAdd,
    this.elevationColor = Constants.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 18.0),
              ),
              Row(
                children: <Widget>[
                  AppIconButton(
                    icon: Icon(
                      isEditing ? Icons.check : Icons.edit,
                      size: 22.0,
                    ),
                    color: elevationColor,
                    elevation: 0.0,
                    onPressed: onEdit,
                  ),
                  SizedBox(width: 8.0),
                  !isEditing
                      ? AppIconButton(
                          icon: Icon(Icons.add),
                          color: elevationColor,
                          elevation: 0.0,
                          onPressed: onAdd,
                        )
                      : SizedBox.shrink(),
                ],
              ),
            ],
          ),
        ),
        Divider(),
        Expanded(
          child: listView,
        ),
      ],
    );
  }
}
