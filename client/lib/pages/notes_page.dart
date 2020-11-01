import 'package:client/utils/app_style.dart';
import 'package:client/view_models/progress_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NotesPage extends StatefulWidget {
  @override
  _NotesPageState createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  ProgressModel model;
  TextEditingController _notesController;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _notesController = TextEditingController();
    model = Provider.of<ProgressModel>(context, listen: false);
    _notesController.text = model.getNotes();
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
          onChanged: (value) => {
            model.setNotes(_notesController.text),
          },
        ),
      ],
    );
  }
}
