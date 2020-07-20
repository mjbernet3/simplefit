import 'package:client/app_style.dart';
import 'package:client/components/exercise_browse/exercise_listing.dart';
import 'package:client/components/shared/app_divider.dart';
import 'package:client/components/shared/rounded_button.dart';
import 'package:client/view_models/exercise_browse_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExerciseBrowsePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        ExerciseListing(),
        Consumer<ExerciseBrowseModel>(
          builder: (BuildContext context, ExerciseBrowseModel model, _) {
            return model.exercises.length > 0
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      AppDivider(),
                      RoundedButton(
                        buttonText: Text(
                          'Add ${model.exercises.length} Exercises',
                          style: TextStyle(color: AppStyle.highEmphasisText),
                        ),
                        height: 30.0,
                        color: AppStyle.dp4,
                        borderColor: AppStyle.dp4,
                        onPressed: () =>
                            Navigator.pop(context, model.exercises),
                      ),
                    ],
                  )
                : SizedBox.shrink();
          },
        ),
      ],
    );
  }
}
