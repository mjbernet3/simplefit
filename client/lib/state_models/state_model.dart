import 'package:client/utils/page_state.dart';
import 'package:flutter/material.dart';

class StateModel extends ChangeNotifier {
  PageState _state = PageState.IDLE;

  PageState get state => _state;

  void setState(PageState state) {
    _state = state;
    notifyListeners();
  }
}
