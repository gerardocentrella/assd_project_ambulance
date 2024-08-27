import 'package:assd_project_ambulance/models/entities/Emergency.dart';
import 'package:assd_project_ambulance/models/entities/Position.dart';
import 'package:assd_project_ambulance/models/entities/Patient.dart';


class PatientReachedNotificationDTO{

    late EmergencyCode _emergencyCode;
    late String _emergencyDescription;
    late EmergencyType _emergencyType;
    late Position _position;
    late Patient _patient;


    PatientReachedNotificationDTO(this._emergencyCode, this._emergencyDescription,
      this._emergencyType, this._position, this._patient);

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

    PatientReachedNotificationDTO.fromJson(Map<String, dynamic> json) {
      emergencyCode = json['emergencyCode'];
      emergencyDescription = json['emergencyDescription'];
      emergencyType = json['emergencyType'];
      position = (json['position'] != null
          ? Position.fromJson(json['position'])
          : null)!;
      patient =
      (json['patient'] != null ? Patient.fromJson(json['patient']) : null)!;
    }

    Map<String, dynamic> toJson() {
      final Map<String, dynamic> data = <String, dynamic>{};
      data['emergencyCode'] = emergencyCode.toString();
      data['emergencyDescription'] = emergencyDescription;
      data['emergencyType'] = emergencyType.toString();
      data['position'] = position.toJson();
      data['patient'] = patient.toJson();
          return data;
    }

/* codice originale senza "pulizia"
    PatientReachedNotificationDTO.fromJson(Map<String, dynamic> json) {
      emergencyCode = json['emergencyCode'];
      emergencyDescription = json['emergencyDescription'];
      emergencyType = json['emergencyType'];
      position = json['position'] != null
          ? new Position.fromJson(json['position'])
          : null;
      patient =
      json['patient'] != null ? new Patient.fromJson(json['patient']) : null;
    }

    Map<String, dynamic> toJson() {
      final Map<String, dynamic> data = new Map<String, dynamic>();
      data['emergencyCode'] = this.emergencyCode;
      data['emergencyDescription'] = this.emergencyDescription;
      data['emergencyType'] = this.emergencyType;
      if (this.position != null) {
        data['position'] = this.position!.toJson();
      }
      if (this.patient != null) {
        data['patient'] = this.patient!.toJson();
      }
      return data;
    }

 */
}