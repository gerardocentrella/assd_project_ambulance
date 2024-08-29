import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class AmbulanceIdRepository {
  static const _ambulanceIdKey = 'ambulance_id';
  SharedPreferences? _sharedPreferences;

  // Initializes SharedPreferences instance
  Future<void> _initPreferences() async {
    _sharedPreferences ??= await SharedPreferences.getInstance();
  }

  // Saves the ambulance ID in shared preferences
  Future<void> saveAmbulanceId(String ambulanceId) async {
    await _initPreferences();
    await _sharedPreferences?.setString(_ambulanceIdKey, ambulanceId);
  }

  // Retrieves the ambulance ID from shared preferences
  Future<String?> getAmbulanceId() async {
    await _initPreferences();
    return _sharedPreferences?.getString(_ambulanceIdKey);
  }

  // Removes the ambulance ID from shared preferences (for logout or reset)
  Future<void> removeAmbulanceId() async {
    await _initPreferences();
    await _sharedPreferences?.remove(_ambulanceIdKey);
  }

  // Checks if an ambulance ID exists in shared preferences
  Future<bool> hasAmbulanceId() async {
    await _initPreferences();
    return _sharedPreferences?.containsKey(_ambulanceIdKey) ?? false;
  }
}