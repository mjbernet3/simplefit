import 'package:flutter/material.dart';

class Constants {
  Constants._();

  static const Color backgroundColor = Color(0xFF131313);
  static const Color firstElevation = Color(0xFF1F1F1F);
  static const Color secondElevation = Color(0xFF2E2E2E);
  static const Color thirdElevation = Color(0xFF363636);

  static const Color highEmphasis = Color(0xDEFFFFFF);
  static const Color medEmphasis = Color(0x99FFFFFF);
  static const Color lowEmphasis = Color(0x61FFFFFF);

  static const Color primaryColor = Color(0xFF6FF9FF);
  static const Color dangerColor = Colors.red;

  static const String lifting = 'Weightlifting';
  static const String timed = 'Timed Cardio';
  static const String distance = 'Distance Cardio';

  static const List<String> exerciseTypes = [
    'Weightlifting',
    'Timed Cardio',
    'Distance Cardio'
  ];

  static const List<String> bodyParts = [
    'Chest',
    'Core',
    'Back',
    'Arms',
    'Legs',
    'Full Body'
  ];
}
