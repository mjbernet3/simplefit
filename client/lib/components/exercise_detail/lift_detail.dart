import 'package:client/app_style.dart';
import 'package:client/components/exercise_detail/lift_set_row.dart';
import 'package:client/components/shared/app_divider.dart';
import 'package:client/components/shared/input_field.dart';
import 'package:client/components/shared/rounded_button.dart';
import 'package:client/models/exercise/lift_set.dart';
import 'package:client/view_models/lift_detail_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LiftDetail extends StatefulWidget {
  @override
  _LiftDetailState createState() => _LiftDetailState();
}

class _LiftDetailState extends State<LiftDetail> {
  TextEditingController _notesController;

  @override
  void initState() {
    super.initState();
    _notesController = TextEditingController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    LiftDetailModel model =
        Provider.of<LiftDetailModel>(context, listen: false);
    _notesController.text = model.liftData.notes;
  }

  @override
  Widget build(BuildContext context) {
    LiftDetailModel model =
        Provider.of<LiftDetailModel>(context, listen: false);
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
        SizedBox(height: 20.0),
        Row(
          children: <Widget>[
            Text(
              'Warm-up Exercise',
              style: TextStyle(
                color: AppStyle.medEmphasisText,
                fontSize: 14.0,
              ),
            ),
            SizedBox(width: 10.0),
            SizedBox(
              height: 15.0,
              width: 15.0,
              child: StreamBuilder<bool>(
                stream: model.warmUpStream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    bool isWarmUp = snapshot.data;

                    return Checkbox(
                      activeColor: AppStyle.primaryColor,
                      checkColor: AppStyle.backgroundColor,
                      value: isWarmUp,
                      onChanged: (_) => model.toggleWarmUp(),
                    );
                  }

                  return Container();
                },
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        AppDivider(),
        SizedBox(height: 14.0),
        StreamBuilder<List<LiftSet>>(
          stream: model.setStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<LiftSet> sets = snapshot.data;

              return Expanded(
                child: ListView(
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        ListView.separated(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: sets.length,
                          separatorBuilder: (BuildContext context, int index) =>
                              SizedBox(height: 4.0),
                          itemBuilder: (BuildContext context, int index) {
                            LiftSet currentSet = sets[index];

                            if (index == 0) {
                              return LiftSetRow(
                                key: ObjectKey(currentSet),
                                index: index,
                                hintsOn: true,
                              );
                            }

                            return LiftSetRow(
                              key: ObjectKey(currentSet),
                              index: index,
                            );
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
            }

            return Container();
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

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }
}
