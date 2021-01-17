import 'package:client/utils/constants.dart';
import 'package:client/view_models/notes_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NotesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    NotesModel _model = Provider.of<NotesModel>(context, listen: false);

    return ListView(
      padding: EdgeInsets.all(0.0),
      shrinkWrap: true,
      children: [
        TextField(
          controller: _model.notesController,
          textInputAction: TextInputAction.newline,
          style: TextStyle(fontSize: 14.0),
          decoration: InputDecoration(
            fillColor: Colors.transparent,
            filled: true,
            border: InputBorder.none,
            counterText: '',
          ),
          maxLines: null,
          keyboardType: TextInputType.multiline,
          onChanged: (_) => _model.updateMessenger(),
        ),
      ],
    );
  }
}
