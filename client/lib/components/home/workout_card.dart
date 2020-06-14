import 'package:client/app_style.dart';
import 'package:flutter/material.dart';

class WorkoutCard extends StatelessWidget {
  final String name;
  final String description;
  final Function onPressed;
  final Function onRemovePressed;
  final bool isEditing;

  const WorkoutCard({
    Key key,
    @required this.name,
    @required this.description,
    this.onPressed,
    this.onRemovePressed,
    this.isEditing = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        isEditing
            ? Expanded(
                flex: 1,
                child: Center(
                  child: GestureDetector(
                    onTap: onRemovePressed,
                    child: Icon(
                      Icons.remove_circle,
                      color: AppStyle.dangerColor,
                    ),
                  ),
                ),
              )
            : SizedBox.shrink(),
        Expanded(
          flex: 10,
          child: GestureDetector(
            onTap: onPressed,
            child: Card(
              color: AppStyle.dp3,
              shadowColor: AppStyle.backgroundColor,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 14.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          name,
                          style: TextStyle(
                            color: AppStyle.highEmphasisText,
                            fontSize: 16.0,
                          ),
                        ),
                        SizedBox(height: 5.0),
                        Text(
                          description,
                          style: TextStyle(
                            color: AppStyle.medEmphasisText,
                            fontSize: 12.0,
                          ),
                        ),
                      ],
                    ),
                    isEditing
                        ? Icon(Icons.drag_handle,
                            color: AppStyle.medEmphasisText)
                        : SizedBox.shrink(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}