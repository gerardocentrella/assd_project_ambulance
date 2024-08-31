import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class EmergencyIdRepository {
  static const _emergencyIdKey = 'emergency_id';
  SharedPreferences? _sharedPreferences;

  // Initializes SharedPreferences instance
  Future<void> _initPreferences() async {
    _sharedPreferences ??= await SharedPreferences.getInstance();
  }

  // Saves the emergency ID in shared preferences
  Future<void> saveEmergencyId(String emergencyId) async {
    await _initPreferences();
    await _sharedPreferences?.setString(_emergencyIdKey, emergencyId);
  }

  // Retrieves the emergency ID from shared preferences
  Future<String?> getEmergencyId() async {
    await _initPreferences();
    return _sharedPreferences?.getString(_emergencyIdKey);
  }

  // Removes the emergency ID from shared preferences (for logout or reset)
  Future<void> removeEmergencyId() async {
    await _initPreferences();
    await _sharedPreferences?.remove(_emergencyIdKey);
  }

  // Checks if an emergency ID exists in shared preferences
  Future<bool> hasEmergencyId() async {
    await _initPreferences();
    return _sharedPreferences?.containsKey(_emergencyIdKey) ?? false;
  }
}