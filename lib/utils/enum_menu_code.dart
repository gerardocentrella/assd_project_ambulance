import 'package:flutter/material.dart';

import '../models/entities/Emergency.dart';

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

/* funzione */
EmergencyCode getEmergencyCode(String label){
  switch(label){
    case 'RED' : return EmergencyCode.RED;
    case 'ORANGE': return EmergencyCode.ORANGE;
    case 'BLUE': return EmergencyCode.BLUE;
    case 'GREEN': return EmergencyCode.GREEN;
    case 'WHITE': return EmergencyCode.WHITE;
    case '': return EmergencyCode.UNDEFINED;
    default: throw Exception();
  }
}

