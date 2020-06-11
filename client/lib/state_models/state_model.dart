import 'package:flutter/material.dart';

class StateModel extends ChangeNotifier {
  bool _loading = false;

  bool get loading => _loading;

  void setLoading(bool state) {
    _loading = state;
    notifyListeners();
  }
}
