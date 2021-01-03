import 'package:client/utils/app_style.dart';
import 'package:client/utils/structures/notes_messenger.dart';
import 'package:flutter/material.dart';

class NotesPage extends StatefulWidget {
  final NotesMessenger messenger;

  const NotesPage({this.messenger});

  @override
  _NotesPageState createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  TextEditingController _notesController;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _notesController = TextEditingController();
    _notesController.text = widget.messenger.notes;
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(0.0),
      shrinkWrap: true,
      children: [
        TextField(
          controller: _notesController,
          textInputAction: TextInputAction.newline,
          style: TextStyle(
            fontSize: 14.0,
            color: AppStyle.highEmphasisText,
          ),
          decoration: InputDecoration(
            fillColor: Colors.transparent,
            filled: true,
            border: InputBorder.none,
            counterText: '',
          ),
          maxLines: null,
          cursorColor: Colors.white,
          keyboardType: TextInputType.multiline,
          onChanged: (_) => {
            widget.messenger.notes = _notesController.text,
          },
        ),
      ],
    );
  }
}
