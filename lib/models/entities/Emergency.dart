import 'dart:ui';

import 'package:flutter/material.dart';

import 'Position.dart';

class Emergency {
  String _id;
  Position _userPosition;
  EmergencyCode _emergencyCode;
  String _description;
  EmergencyStatus _emergencyStatus;
  EmergencyType _emergencyType;
  String _ambulanceId;
  String _erId; // emergency Room

  Emergency(
      {required String id,
      required Position userPosition,
      required EmergencyCode emergencyCode,
      required String description,
      required EmergencyStatus emergencyStatus,
      required EmergencyType emergencyType,
      required String ambulanceId,
      required String erId})
      : _id = id,
        _userPosition = userPosition,
        _emergencyCode = emergencyCode,
        _description = description,
        _emergencyStatus = emergencyStatus,
        _emergencyType = emergencyType,
        _ambulanceId = ambulanceId,
        _erId = erId;

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
}

enum EmergencyCode { RED, ORANGE, BLUE, GREEN, WHITE }

// enum code

// enum status
enum EmergencyStatus {
  SUBMITTED,
  AMBULANCE_SELECTED,
  ER_SELECTED,
  FULFILLED,
  FAILED
}

// enum type
enum EmergencyType {
  C01_TRAUMATICA,
  C02_CARDIOCIRCOLATORIA,
  C03_RESPIRATORIA,
  C04_NEUROLOGICA,
  C05_PSICHIATRICA,
  C06_NEOPLASTICA,
  CO7_TOSSICOLOGICA,
  CO8_METABOLICA,
  C09_GASTROENTEROLOGICA,
  C10_UROLOGICA,
  C11_OCULISTICA,
  C12_OTORINOLARINGOIATRICA,
  C13_DERMATOLOGICA,
  C14_OSTETRICO_GINECOLOGICA,
  C15_INFETTIVA,
  C19_ALTRA_PATOLOGIA,
  C20_PATOLOGIA_NON_IDENTIFICATA;

  String get description {
    switch (this) {
      case EmergencyType.C01_TRAUMATICA:
        return 'C01_TRAUMATICA';
      case EmergencyType.C02_CARDIOCIRCOLATORIA:
        return 'C02_CARDIOCIRCOLATORIA';
      case EmergencyType.C03_RESPIRATORIA:
        return 'C03_RESPIRATORIA';
      case EmergencyType.C04_NEUROLOGICA:
        return 'C04_NEUROLOGICA';
      case EmergencyType.C05_PSICHIATRICA:
        return 'C05_PSICHIATRICA';
      case EmergencyType.C06_NEOPLASTICA:
        return 'C06_NEOPLASTICA';
      case EmergencyType.CO7_TOSSICOLOGICA:
        return 'CO7_TOSSICOLOGICA';
      case EmergencyType.CO8_METABOLICA:
        return 'CO8_METABOLICA';
      case EmergencyType.C09_GASTROENTEROLOGICA:
        return 'C09_GASTROENTEROLOGICA';
      case EmergencyType.C10_UROLOGICA:
        return 'C10_UROLOGICA';
      case EmergencyType.C11_OCULISTICA:
        return 'C11_OCULISTICA';
      case EmergencyType.C12_OTORINOLARINGOIATRICA:
        return 'C12_OTORINOLARINGOIATRICA';
      case EmergencyType.C13_DERMATOLOGICA:
        return 'C13_DERMATOLOGICA';
      case EmergencyType.C14_OSTETRICO_GINECOLOGICA:
        return 'C14_OSTETRICO_GINECOLOGICA';
      case EmergencyType.C15_INFETTIVA:
        return 'C15_INFETTIVA';
      case EmergencyType.C19_ALTRA_PATOLOGIA:
        return 'C19_ALTRA_PATOLOGIA';
      case EmergencyType.C20_PATOLOGIA_NON_IDENTIFICATA:
        return 'C20_PATOLOGIA_NON_IDENTIFICATA';
    }
  }

}


