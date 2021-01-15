import 'dart:async';
import 'package:client/view_models/view_model.dart';

class HomeModel extends ViewModel {
  final StreamController<bool> _editingController = StreamController<bool>();

  Stream<bool> get isEditing => _editingController.stream;

  void setEditing(bool value) {
    _editingController.sink.add(value);
  }

  @override
  void dispose() {
    _editingController.close();
  }
}
