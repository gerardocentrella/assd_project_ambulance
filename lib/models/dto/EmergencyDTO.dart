import 'package:assd_project_ambulance/models/entities/Emergency.dart';
import 'package:assd_project_ambulance/models/entities/Position.dart';


class EmergencyDTO {

  late String _id;
  late Position _userPosition;
  late EmergencyCode _emergencyCode;
  late String _description;
  late EmergencyStatus _emergencyStatus;
  late EmergencyType _emergencyType;
  late String _ambulanceId;
  late String _erId; // emergency Room
  late String _emergencyUpdateURL;
  late String _ambulancePositionUpdateURL;


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

  EmergencyDTO.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userPosition = (json['userPosition'] != null
        ? Position.fromJson(json['userPosition'])
        : null)!;
    emergencyCode = json['emergencyCode'];
    emergencyStatus = json['emergencyStatus'];
    description = json['emergencyDescription'];
    emergencyType = json['emergencyType'];
    ambulanceId = json['ambulanceId'];
    erId = json['erId'];
    emergencyUpdateURL = json['emergencyUpdateURL'];
    ambulancePositionUpdateURL = json['ambulancePositionUpdateURL'];
  }

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
    data['emergencyUpdateURL'] = emergencyUpdateURL;
    data['ambulancePositionUpdateURL'] = ambulancePositionUpdateURL;
    return data;
  }

/* codice originale
  EmergencyDTO.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userPosition = json['userPosition'] != null
        ? new UserPosition.fromJson(json['userPosition'])
        : null;
    emergencyCode = json['emergencyCode'];
    emergencyStatus = json['emergencyStatus'];
    emergencyDescription = json['emergencyDescription'];
    emergencyType = json['emergencyType'];
    ambulanceId = json['ambulanceId'];
    emergencyid = json['emergencyid'];
    emergencyUpdateURL = json['emergencyUpdateURL'];
    ambulancePositionUpdateURL = json['ambulancePositionUpdateURL'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.userPosition != null) {
      data['userPosition'] = this.userPosition!.toJson();
    }
    data['emergencyCode'] = this.emergencyCode;
    data['emergencyStatus'] = this.emergencyStatus;
    data['emergencyDescription'] = this.emergencyDescription;
    data['emergencyType'] = this.emergencyType;
    data['ambulanceId'] = this.ambulanceId;
    data['emergencyid'] = this.emergencyid;
    data['emergencyUpdateURL'] = this.emergencyUpdateURL;
    data['ambulancePositionUpdateURL'] = this.ambulancePositionUpdateURL;
    return data;
  }

 */
}


