part of 'patient_form_bloc.dart';

abstract class PatientFormEvent extends Equatable {
  const PatientFormEvent();

  @override
  List<Object?> get props => [];
}

class PatientFormEventSubmit extends PatientFormEvent {
  final String name;
  final String surname;
  final String city;
  final String address;
  final int age;
  final double latitude;
  final double longitude;
  final EmergencyCode emerCode;
  final EmergencyType type;
  final String emergencyDescription;

  const PatientFormEventSubmit({
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
        emergencyDescription,
      ];
}

class PatientFormEventSuccess extends PatientFormEvent {}

class PatientFormEventFailure extends PatientFormEvent {
  final String error;

  const PatientFormEventFailure({required this.error});

  @override
  List<Object?> get props => [error];
}
