import 'package:client/app_style.dart';
import 'package:client/view_models/lift_form_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WarmUpCheck extends StatefulWidget {
  @override
  _WarmUpCheckState createState() => _WarmUpCheckState();
}

class _WarmUpCheckState extends State<WarmUpCheck> {
  bool isWarmUp;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    LiftFormModel model = Provider.of<LiftFormModel>(context, listen: false);
    isWarmUp = model.isWarmUp;
  }

  @override
  Widget build(BuildContext context) {
    LiftFormModel model = Provider.of<LiftFormModel>(context, listen: false);
    return Row(
      children: <Widget>[
        Text(
          'Warm-up Exercise',
          style: TextStyle(color: AppStyle.medEmphasisText),
        ),
        SizedBox(width: 10.0),
        SizedBox(
          height: 15.0,
          width: 15.0,
          child: Checkbox(
            activeColor: AppStyle.primaryColor,
            checkColor: AppStyle.backgroundColor,
            value: isWarmUp,
            onChanged: (status) => {
              model.isWarmUp = status,
              setState(() => isWarmUp = status),
            },
          ),
        ),
      ],
    );
  }
}
