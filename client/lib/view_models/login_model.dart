import 'dart:async';
import 'package:client/services/auth_service.dart';
import 'package:client/utils/structures/auth_info.dart';
import 'package:client/view_models/view_model.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter/material.dart';

class LoginModel extends ViewModel {
  TextEditingController _emailController;
  TextEditingController _passwordController;
  AuthService _authService;

  LoginModel({AuthService authService}) {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _authService = authService;
  }

  final StreamController<bool> _loadingController = BehaviorSubject<bool>();

  final StreamController<bool> _autovalidateController =
      StreamController<bool>();

  Stream<bool> get isLoading => _loadingController.stream;

  Stream<bool> get autovalidate => _autovalidateController.stream;

  TextEditingController get emailController => _emailController;

  TextEditingController get passwordController => _passwordController;

  void setAutovalidate(bool value) {
    _autovalidateController.sink.add(value);
  }

  Future<void> signIn() async {
    AuthInfo authInfo = AuthInfo(
      email: _emailController.text,
      password: _passwordController.text,
    );

    _loadingController.sink.add(true);

    try {
      await _authService.signIn(authInfo);
    } catch (e) {
      _loadingController.sink.add(false);
      rethrow;
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _loadingController.close();
    _autovalidateController.close();
  }
}
