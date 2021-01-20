import 'package:client/components/shared/small_input_field.dart';
import 'package:client/utils/constants.dart';
import 'package:flutter/material.dart';

class DetailCard extends StatelessWidget {
  final String title;
  final String inputUnit;
  final String initialValue;
  final Function onChanged;

  DetailCard({
    @required this.title,
    @required this.inputUnit,
    this.initialValue,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              title,
              style: TextStyle(fontSize: 16.0),
            ),
            Column(
              children: [
                SmallInputField(
                  initialValue: initialValue,
                  fillColor: Constants.secondElevation,
                  onChanged: onChanged,
                ),
                SizedBox(height: 4.0),
                Text(
                  inputUnit,
                  style: TextStyle(color: Constants.medEmphasis),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
