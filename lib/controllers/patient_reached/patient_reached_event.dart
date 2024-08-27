// patient_reached_event.dart
import 'package:equatable/equatable.dart';

import '../../models/entities/Emergency.dart';
import '../../utils/enum_menu_code.dart';

abstract class PatientReachedEvent extends Equatable {
  const PatientReachedEvent();

  @override
  List<Object?> get props => [];
}

class SubmitPatientData extends PatientReachedEvent {
  final String name;
  final String surname;
  final String city;
  final String address;
  final int age;
  final double latitude;
  final double longitude;
  final EmergencyCode? emerCode;
  final EmergencyType type;
  final String emergencyDescription;

  const SubmitPatientData({
    required this.name,
    required this.surname,
    required this.city,
    required this.address,
    required this.age,
    required this.latitude,
    required this.longitude,
    required this.emerCode,
    required this.type,
    required this.emergencyDescription,
  });

  @override
  List<Object?> get props => [
    name,
    surname,
    city,
    address,
    age,
    latitude,
    longitude,
    emerCode,
    type,
    emergencyDescription
  ];
}
