import 'package:assd_project_ambulance/models/entities/Emergency.dart';
import 'package:assd_project_ambulance/models/entities/Position.dart';
import 'package:assd_project_ambulance/models/entities/Patient.dart';

import '../../utils/enum_menu_code.dart';


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
/*
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

 */

  // metodo per deserializzare: noi non lo usiamo!
  PatientReachedNotificationDTO.fromJson(Map<String, dynamic> json) {
    emergencyCode = json['emergencyCode'] != null
        ? getEmergencyCode(json['emergencyCode'])
        : throw Exception('Codice di emergenza mancante');

    emergencyDescription = json['emergencyDescription'] ?? 'Descrizione mancante'; // valore di default o gestione dell'errore
    emergencyType = json['emergencyType'] != null
        ? getEmergencyType(json['emergencyType'])
        : throw Exception('Tipo di emergenza mancante');

    position = (json['position'] != null
        ? Position.fromJson(json['position'])
        : throw Exception('La posizione è mancante'));

    patient = (json['patient'] != null
        ? Patient.fromJson(json['patient'])
        : throw Exception('Il paziente è mancante'));
  }

  // metodo per serializzare, utilizziamo solo questo
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['emergencyCode'] = emergencyCode.toString().split('.').last; // Solo il nome dell'enum
    data['emergencyDescription'] = emergencyDescription;
    data['emergencyType'] = emergencyType.toString().split('.').last; // Solo il nome dell'enum
    data['position'] = position.toJson();
    data['patient'] = patient.toJson();
    return data;
  }

}