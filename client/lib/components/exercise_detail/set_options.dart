import 'package:client/app_style.dart';
import 'package:client/state_models/lift_form_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum PopupChoice {
  WARM_UP,
  REMOVE,
}

class SetOptions extends StatefulWidget {
  final int index;

  SetOptions({this.index});

  @override
  _SetOptionsState createState() => _SetOptionsState();
}

class _SetOptionsState extends State<SetOptions> {
  bool isWarmUp;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    LiftFormModel model = Provider.of<LiftFormModel>(context, listen: false);
    isWarmUp = model.newSets[widget.index].isWarmUp;
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<PopupChoice>(
      icon: Icon(
        Icons.more_vert,
        color: AppStyle.medEmphasisText,
      ),
      color: AppStyle.dp2,
      onSelected: (PopupChoice value) => _handleChoice(value, context),
      itemBuilder: (BuildContext context) => <PopupMenuEntry<PopupChoice>>[
        PopupMenuItem<PopupChoice>(
          value: PopupChoice.WARM_UP,
          child: Row(
            children: <Widget>[
              Text('Warm up set'),
              isWarmUp
                  ? Row(
                      children: <Widget>[
                        SizedBox(width: 5.0),
                        Icon(Icons.check),
                      ],
                    )
                  : SizedBox.shrink(),
            ],
          ),
        ),
        PopupMenuItem<PopupChoice>(
          value: PopupChoice.REMOVE,
          child: Text('Remove this set'),
        ),
      ],
    );
  }

  void _handleChoice(PopupChoice choice, BuildContext context) {
    LiftFormModel model = Provider.of<LiftFormModel>(context, listen: false);
    switch (choice) {
      case PopupChoice.REMOVE:
        model.removeSet(widget.index);
        break;
      case PopupChoice.WARM_UP:
        model.newSets[widget.index].isWarmUp = !isWarmUp;

        setState(() => isWarmUp = !isWarmUp);
        break;
      default:
        break;
    }
  }
}
