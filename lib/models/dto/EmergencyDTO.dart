import 'package:assd_project_ambulance/models/entities/Emergency.dart';
import 'package:assd_project_ambulance/models/entities/Position.dart';
import 'package:assd_project_ambulance/utils/enum_menu_code.dart';

class EmergencyDTO {
  late String _id;
  late Position _userPosition;
  late EmergencyCode _emergencyCode;
  late String _description;
  late EmergencyStatus _emergencyStatus;
  late EmergencyType _emergencyType;
  late String _ambulanceId;
  late String _erId; // emergency Room

  EmergencyDTO({required Emergency emergency})
      : _id = emergency.id,
        _userPosition = emergency.userPosition,
        _emergencyCode = emergency.emergencyCode,
        _description = emergency.description,
        _emergencyStatus = emergency.emergencyStatus,
        _emergencyType = emergency.emergencyType,
        _ambulanceId = emergency.ambulanceId,
        _erId = emergency.erId;

  // getters & setters

  String get id => _id;

  set id(String value) {
    _id = value;
  }

  Position get userPosition => _userPosition;

  set userPosition(Position value) {
    _userPosition = value;
  }

  String get erId => _erId;

  set erId(String value) {
    _erId = value;
  }

  String get ambulanceId => _ambulanceId;

  set ambulanceId(String value) {
    _ambulanceId = value;
  }

  EmergencyType get emergencyType => _emergencyType;

  set emergencyType(EmergencyType value) {
    _emergencyType = value;
  }

  EmergencyStatus get emergencyStatus => _emergencyStatus;

  set emergencyStatus(EmergencyStatus value) {
    _emergencyStatus = value;
  }

  String get description => _description;

  set description(String value) {
    _description = value;
  }

  EmergencyCode get emergencyCode => _emergencyCode;

  set emergencyCode(EmergencyCode value) {
    _emergencyCode = value;
  }

  // Costruttore per la costruzione dell'oggetto da JSON
  EmergencyDTO.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? '';
    userPosition = json['userPosition'] != null
        ? Position.fromJson(json['userPosition'])
        : Position(latitude: 0.0, longitude: 0.0); // Valori di default se null

    emergencyCode = getEmergencyCode(json['emergencyCode'] ?? '');
    emergencyStatus = getEmergencyStatus(json['emergencyStatus'] ?? '');
    description = json['emergencyDescription'] ?? ''; // Valore di default
    emergencyType = getEmergencyType(json['emergencyType'] ?? '');

    ambulanceId = json['ambulanceId'] ?? ''; // Valore di default
    erId = json['erId'] ?? ''; // Valore di default
  }

// Metodo per conversione in JSON di un EmergencyDTO
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['userPosition'] = userPosition.toJson();
    data['emergencyCode'] = emergencyCode;
    data['emergencyStatus'] = emergencyStatus;
    data['emergencyDescription'] = description;
    data['emergencyType'] = emergencyType;
    data['ambulanceId'] = ambulanceId;
    data['erId'] = erId;
    return data;
  }

}
