import 'dart:async';
import 'package:client/services/auth_service.dart';
import 'package:client/utils/structures/auth_info.dart';
import 'package:client/view_models/view_model.dart';
import 'package:rxdart/rxdart.dart';

class RegisterModel extends ViewModel {
  AuthService _authService;

  RegisterModel({AuthService authService}) : _authService = authService;

  final StreamController<bool> _loadingController = BehaviorSubject<bool>();

  final StreamController<bool> _autovalidateController =
      StreamController<bool>();

  Stream<bool> get isLoading => _loadingController.stream;

  Stream<bool> get autovalidate => _autovalidateController.stream;

  void setAutovalidate(bool value) {
    _autovalidateController.sink.add(value);
  }

  Future<void> register(AuthInfo authInfo) async {
    _loadingController.sink.add(true);

    try {
      await _authService.register(authInfo);
    } catch (e) {
      _loadingController.sink.add(false);
      rethrow;
    }
  }

  @override
  void dispose() {
    _loadingController.close();
    _autovalidateController.close();
  }
}
