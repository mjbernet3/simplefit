import 'package:client/utils/app_style.dart';
import 'package:flutter/material.dart';

class ExerciseDropdown extends StatefulWidget {
  final String hintText;
  final String initialValue;
  final List<String> items;
  final Function onChanged;
  final Function validator;
  final bool enabled;

  const ExerciseDropdown({
    this.hintText,
    this.initialValue,
    this.items,
    this.onChanged,
    this.validator,
    this.enabled = true,
  });

  @override
  _ExerciseDropdownState createState() => _ExerciseDropdownState();
}

class _ExerciseDropdownState extends State<ExerciseDropdown> {
  String selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      dropdownColor: AppStyle.thirdElevation,
      hint: Text(widget.hintText),
      value: selectedValue,
      isExpanded: true,
      style: TextStyle(color: AppStyle.highEmphasis),
      items: widget.items
          .map(
            (String item) => DropdownMenuItem<String>(
              value: item,
              child: Text(item),
            ),
          )
          .toList(),
      validator: widget.validator,
      onChanged: widget.enabled
          ? (String value) {
              widget.onChanged(value);
              setState(() {
                selectedValue = value;
              });
            }
          : null,
    );
  }
}
