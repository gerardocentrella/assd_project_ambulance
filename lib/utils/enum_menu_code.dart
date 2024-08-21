import 'package:flutter/material.dart';

enum EmergencyCodeLabel {
  red('RED', Colors.red),
  orange('ORANGE', Colors.orange),
  blue('BLUE', Colors.blue),
  green('GREEN', Colors.green),
  white('WHITE', Colors.white);

  const EmergencyCodeLabel(this.label, this.color);
  final String label;
  final Color color;
}