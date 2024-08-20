import 'package:assd_project_ambulance/models/entities/Emergency.dart';
import 'package:assd_project_ambulance/models/entities/Position.dart';


class EmergencyDTO {

  String _id;
  Position _userPosition;
  EmergencyCode _emergencyCode;
  String _description;
  EmergencyStatus _emergencyStatus;
  EmergencyType _emergencyType;
  String _ambulanceId;
  String _erId; // emergency Room
  String _emergencyUpdateURL;
  String _ambulancePositionUpdateURL;


  EmergencyDTO(
      {required Emergency emergency, required String emergencyUpdateURL, required String ambulancePositionUpdateURL}
      ) :
    _id = emergency.id,
    _userPosition = emergency.userPosition,
    _emergencyCode = emergency.emergencyCode,
    _description = emergency.description,
    _emergencyStatus = emergency.emergencyStatus,
    _emergencyType = emergency.emergencyType,
    _ambulanceId = emergency.ambulanceId,
    _erId = emergency.erId,
    _emergencyUpdateURL = emergencyUpdateURL,
    _ambulancePositionUpdateURL = ambulancePositionUpdateURL;



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

  String get ambulancePositionUpdateURL => _ambulancePositionUpdateURL;

  set ambulancePositionUpdateURL(String value) {
    _ambulancePositionUpdateURL = value;
  }

  String get emergencyUpdateURL => _emergencyUpdateURL;

  set emergencyUpdateURL(String value) {
    _emergencyUpdateURL = value;
  }
}
