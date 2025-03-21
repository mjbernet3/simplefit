import 'package:client/utils/constants.dart';
import 'package:flutter/material.dart';

class AppDropdownButton extends StatefulWidget {
  final String hintText;
  final String? initialValue;
  final List<String> items;
  final Function onChanged;
  final FormFieldValidator<String> validator;
  final bool enabled;

  const AppDropdownButton({
    required this.hintText,
    required this.items,
    required this.onChanged,
    required this.validator,
    this.initialValue,
    this.enabled = true,
  });

  @override
  _AppDropdownButtonState createState() => _AppDropdownButtonState();
}

class _AppDropdownButtonState extends State<AppDropdownButton> {
  late String? _selectedValue;

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

  void _selectItem(String? value) {
    if (value != null) {
      setState(() => _selectedValue = value);
      widget.onChanged(_selectedValue);
    }
  }
}
