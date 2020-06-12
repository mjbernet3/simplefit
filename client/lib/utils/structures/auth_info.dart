import 'package:flutter/material.dart';

class AuthInfo {
  final String email;
  final String password;
  final String username;

  const AuthInfo({
    @required this.email,
    @required this.password,
    this.username,
  });
}
