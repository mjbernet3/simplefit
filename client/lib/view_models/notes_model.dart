import 'package:client/utils/structures/notes_messenger.dart';
import 'package:client/view_models/view_model.dart';
import 'package:flutter/material.dart';

class NotesModel extends ViewModel {
  TextEditingController _notesController;
  NotesMessenger _messenger;

  NotesModel({NotesMessenger messenger}) {
    _notesController = TextEditingController();
    _messenger = messenger;
    _notesController.text = _messenger.notes;
  }

  TextEditingController get notesController => _notesController;

  void updateMessenger() {
    _messenger.notes = _notesController.text;
  }

  @override
  void dispose() {
    _notesController.dispose();
  }
}
