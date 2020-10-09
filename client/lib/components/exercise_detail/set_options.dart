import 'package:client/app_style.dart';
import 'package:client/models/exercise/lift_set.dart';
import 'package:client/view_models/lift_detail_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum PopupChoice {
  WARM_UP,
  REMOVE,
}

class SetOptions extends StatefulWidget {
  final int index;

  const SetOptions({this.index});

  @override
  _SetOptionsState createState() => _SetOptionsState();
}

class _SetOptionsState extends State<SetOptions> {
  bool isWarmUp;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    LiftDetailModel model =
        Provider.of<LiftDetailModel>(context, listen: false);
    List<LiftSet> sets = model.getSets();

    isWarmUp = sets[widget.index].isWarmUp;
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
    LiftDetailModel model =
        Provider.of<LiftDetailModel>(context, listen: false);
    List<LiftSet> sets = model.getSets();

    switch (choice) {
      case PopupChoice.WARM_UP:
        sets[widget.index].isWarmUp = !isWarmUp;

        setState(() => isWarmUp = !isWarmUp);
        break;
      case PopupChoice.REMOVE:
        model.removeSetAt(widget.index);
        break;
      default:
        break;
    }
  }
}
