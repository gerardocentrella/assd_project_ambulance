import 'package:assd_project_ambulance/models/entities/Emergency.dart';
import 'package:assd_project_ambulance/models/entities/Position.dart';
import 'package:assd_project_ambulance/models/entities/Patient.dart';


class PatientReachedNotificationDTO{

    EmergencyCode _emergencyCode;
    String _emergencyDescription;
    EmergencyType _emergencyType;
    Position _position;
    Patient _patient;

    PatientReachedNotificationDTO.name(
      this._emergencyCode,
      this._emergencyDescription,
      this._emergencyType,
      this._position,
      this._patient);

    Patient get patient => _patient;

    set patient(Patient value) {
      _patient = value;
    }

    Position get position => _position;

    set position(Position value) {
      _position = value;
    }

    EmergencyType get emergencyType => _emergencyType;

    set emergencyType(EmergencyType value) {
      _emergencyType = value;
    }

    String get emergencyDescription => _emergencyDescription;

    set emergencyDescription(String value) {
      _emergencyDescription = value;
    }

    EmergencyCode get emergencyCode => _emergencyCode;

    set emergencyCode(EmergencyCode value) {
      _emergencyCode = value;
    }
}