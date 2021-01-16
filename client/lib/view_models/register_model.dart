import 'dart:async';
import 'package:client/services/auth_service.dart';
import 'package:client/utils/structures/auth_info.dart';
import 'package:client/view_models/view_model.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class RegisterModel extends ViewModel {
  TextEditingController _emailController;
  TextEditingController _usernameController;
  TextEditingController _passwordController;
  AuthService _authService;

  RegisterModel({AuthService authService}) {
    _emailController = TextEditingController();
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
    _authService = authService;
  }

  final StreamController<bool> _loadingController = BehaviorSubject<bool>();

  final StreamController<bool> _autovalidateController =
      StreamController<bool>();

  Stream<bool> get isLoading => _loadingController.stream;

  Stream<bool> get autovalidate => _autovalidateController.stream;

  TextEditingController get emailController => _emailController;

  TextEditingController get usernameController => _usernameController;

  TextEditingController get passwordController => _passwordController;

  void setAutovalidate(bool value) {
    _autovalidateController.sink.add(value);
  }

  Future<void> register() async {
    AuthInfo authInfo = AuthInfo(
      email: _emailController.text,
      username: _usernameController.text,
      password: _passwordController.text,
    );

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
    _emailController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _loadingController.close();
    _autovalidateController.close();
  }
}
