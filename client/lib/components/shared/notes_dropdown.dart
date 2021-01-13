import 'package:client/utils/constants.dart';
import 'package:client/utils/app_router.dart';
import 'package:client/utils/structures/notes_messenger.dart';
import 'package:client/utils/structures/route_arguments.dart';
import 'package:flutter/material.dart';

class NotesDropdown extends StatefulWidget {
  final String notes;
  final Function onComplete;

  NotesDropdown({this.notes, this.onComplete});

  @override
  _NotesDropdownState createState() => _NotesDropdownState();
}

class _NotesDropdownState extends State<NotesDropdown> {
  String _currentNotes;
  bool _hidden = true;

  @override
  void initState() {
    super.initState();
    _currentNotes = widget.notes;
  }

  @override
  void didUpdateWidget(NotesDropdown oldWidget) {
    if (widget.notes != oldWidget.notes) {
      setState(() => _currentNotes = widget.notes);
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 5.0),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Constants.thirdElevation,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Notes',
            style: TextStyle(
              fontSize: 16.0,
              color: Constants.medEmphasis,
            ),
          ),
          GestureDetector(
            onTap: () => _toggleNotes(),
            child: Icon(
              _hidden ? Icons.expand_more : Icons.expand_less,
              color: Constants.medEmphasis,
            ),
          )
        ],
      ),
    );
  }

  void _toggleNotes() async {
    setState(() => _hidden = false);

    RenderBox renderBox = context.findRenderObject();
    NotesMessenger messenger = NotesMessenger(notes: _currentNotes);

    await Navigator.pushNamed(
      context,
      AppRouter.notes,
      arguments: RouteArguments(
        arguments: {
          "renderBox": renderBox,
          "messenger": messenger,
        },
      ),
    );

    setState(
      () => {
        _currentNotes = messenger.notes,
        _hidden = true,
      },
    );

    widget.onComplete(_currentNotes);
  }
}
