import 'package:flutter/material.dart';

extension StringExtension on String {
  int get toInt => int.tryParse(this) ?? 0;
  double get toDouble => double.tryParse(this) ?? 0.0;

  String get isValidNum => isEmpty ? "0" : this;

  TimeOfDay get toTimeOfDay {
    final parts = split(':');
    return TimeOfDay(
      hour: int.tryParse(parts[0]) ?? 0,
      minute: int.tryParse(parts[1]) ?? 0,
    );
  }
}
