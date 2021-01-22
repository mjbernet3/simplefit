import 'package:client/utils/constants.dart';
import 'package:flutter/material.dart';

class AppDropdownButton extends StatefulWidget {
  final String hintText;
  final String initialValue;
  final List<String> items;
  final Function onChanged;
  final Function validator;
  final bool enabled;

  const AppDropdownButton({
    this.hintText,
    this.initialValue,
    this.items,
    this.onChanged,
    this.validator,
    this.enabled = true,
  });

  @override
  _AppDropdownButtonState createState() => _AppDropdownButtonState();
}

class _AppDropdownButtonState extends State<AppDropdownButton> {
  String _selectedValue;

  @override
  void initState() {
    _selectedValue = widget.initialValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      dropdownColor: Constants.thirdElevation,
      hint: Text(widget.hintText),
      value: _selectedValue,
      isExpanded: true,
      style: const TextStyle(fontSize: 14.0),
      items: widget.items
          .map(
            (String item) => DropdownMenuItem<String>(
              value: item,
              child: Text(item),
            ),
          )
          .toList(),
      validator: widget.validator,
      onChanged: widget.enabled ? _selectItem : null,
    );
  }

  void _selectItem(String value) {
    setState(() => _selectedValue = value);
    widget.onChanged(_selectedValue);
  }
}
