import 'package:client/app_style.dart';
import 'package:flutter/material.dart';

class ExerciseDropdown extends StatefulWidget {
  final String hintText;
  final List<String> items;
  final Function onChanged;

  const ExerciseDropdown({
    this.hintText,
    this.items,
    this.onChanged,
  });

  @override
  _ExerciseDropdownState createState() => _ExerciseDropdownState();
}

class _ExerciseDropdownState extends State<ExerciseDropdown> {
  String selectedValue;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      hint: Text(widget.hintText),
      value: selectedValue,
      isExpanded: true,
      style: TextStyle(color: AppStyle.highEmphasisText),
      items: widget.items
          .map(
            (String item) => DropdownMenuItem<String>(
              value: item,
              child: Text(item),
            ),
          )
          .toList(),
      onChanged: (String value) {
        widget.onChanged(value);
        setState(() {
          selectedValue = value;
        });
      },
    );
  }
}
