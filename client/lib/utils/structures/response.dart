import 'package:flutter/material.dart';

class Response {
  final Status status;
  final String message;

  const Response({
    @required this.status,
    this.message,
  });
}

enum Status {
  SUCCESS,
  FAILURE,
}
