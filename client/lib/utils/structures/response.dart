import 'package:flutter/material.dart';

enum Status {
  SUCCESS,
  FAILURE,
}

class Response {
  final Status status;
  final String message;

  const Response({
    @required this.status,
    this.message,
  });
}
