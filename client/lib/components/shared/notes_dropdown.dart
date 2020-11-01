import 'package:client/utils/app_style.dart';
import 'package:client/utils/router.dart';
import 'package:flutter/material.dart';

class NotesDropdown extends StatefulWidget {
  @override
  _NotesDropdownState createState() => _NotesDropdownState();
}

class _NotesDropdownState extends State<NotesDropdown> {
  bool _hidden = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 5.0),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: AppStyle.dp24,
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
              color: AppStyle.medEmphasisText,
            ),
          ),
          GestureDetector(
            onTap: () => _toggleNotes(),
            child: Icon(
              _hidden ? Icons.expand_more : Icons.expand_less,
              color: AppStyle.medEmphasisText,
            ),
          )
        ],
      ),
    );
  }

  void _toggleNotes() async {
    setState(() => _hidden = !_hidden);

    RenderBox renderBox = context.findRenderObject();
    await Navigator.pushNamed(
      context,
      Router.notes,
      arguments: renderBox,
    );

    setState(() => _hidden = !_hidden);
  }
}
