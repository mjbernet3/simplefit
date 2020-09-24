import 'package:flutter/material.dart';

enum Status {
  SUCCESS,
  FAILURE,
}

class Response {
  final Status status;
  final String message;
  final dynamic data;

  const Response({
    @required this.status,
    this.message,
    this.data,
  });
}
