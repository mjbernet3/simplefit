import 'package:client/components/shared/small_input_field.dart';
import 'package:flutter/material.dart';

class DetailCard extends StatelessWidget {
  final String text;
  final String initialValue;
  final Function onChanged;

  const DetailCard({
    @required this.text,
    this.initialValue,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          text,
          style: TextStyle(fontSize: 16.0),
        ),
        SmallInputField(
          initialValue: initialValue,
          onChanged: onChanged,
        ),
      ],
    );
  }
}