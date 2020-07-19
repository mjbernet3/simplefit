import 'package:client/app_style.dart';
import 'package:client/components/exercise_detail/lift_set_row.dart';
import 'package:client/components/shared/app_divider.dart';
import 'package:client/components/shared/input_field.dart';
import 'package:client/components/shared/rounded_button.dart';
import 'package:client/state_models/lift_form_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LiftForm extends StatefulWidget {
  @override
  _LiftFormState createState() => _LiftFormState();
}

class _LiftFormState extends State<LiftForm> {
  TextEditingController _notesController;

  @override
  void initState() {
    super.initState();
    _notesController = TextEditingController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    LiftFormModel model = Provider.of<LiftFormModel>(context, listen: false);
    _notesController.text = model.liftData.notes;
  }

  @override
  Widget build(BuildContext context) {
    LiftFormModel model = Provider.of<LiftFormModel>(context, listen: false);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          model.liftData.exercise.name,
          style: TextStyle(
            fontSize: 24.0,
          ),
        ),
        SizedBox(height: 14.0),
        InputField(
          controller: _notesController,
          hintText: 'Notes...',
          keyboardType: TextInputType.multiline,
          textInputAction: TextInputAction.newline,
          maxLines: null,
        ),
        SizedBox(height: 14.0),
        AppDivider(),
        SizedBox(height: 14.0),
        Consumer<LiftFormModel>(
          builder: (BuildContext context, LiftFormModel model, _) {
            return Expanded(
              child: ListView(
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: model.sets.length,
                        separatorBuilder: (BuildContext context, int index) =>
                            SizedBox(height: 10.0),
                        itemBuilder: (BuildContext context, int index) {
                          if (index == 0) {
                            return LiftSetRow(index: index, hintsOn: true);
                          }

                          return LiftSetRow(index: index);
                        },
                      ),
                      SizedBox(height: 14.0),
                      RoundedButton(
                        buttonText: Text(
                          'Add Set',
                          style: TextStyle(
                            color: AppStyle.highEmphasisText,
                          ),
                        ),
                        height: 30.0,
                        color: AppStyle.dp4,
                        borderColor: AppStyle.dp4,
                        onPressed: () => model.addSet(),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
        Column(
          children: <Widget>[
            AppDivider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                RoundedButton(
                  buttonText: Text(
                    'Cancel',
                    style: TextStyle(color: AppStyle.highEmphasisText),
                  ),
                  height: 30.0,
                  color: AppStyle.dp4,
                  borderColor: AppStyle.dp4,
                  onPressed: () => Navigator.pop(context),
                ),
                RoundedButton(
                  buttonText: Text(
                    'Save Changes',
                    style: TextStyle(color: AppStyle.highEmphasisText),
                  ),
                  height: 30.0,
                  color: AppStyle.dp4,
                  borderColor: AppStyle.dp4,
                  onPressed: () {
                    model.liftData.sets = model.sets;
                    model.liftData.notes = _notesController.text;
                    Navigator.pop(context, model.liftData);
                  },
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}