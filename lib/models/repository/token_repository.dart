import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class TokenRepository {
  static const _tokenKey = 'user_token';
  SharedPreferences? _sharedPreferences;

  // Initializes SharedPreferences instance
  Future<void> _initPreferences() async {
    _sharedPreferences ??= await SharedPreferences.getInstance();
  }

  // Saves the token in shared preferences
  Future<void> saveToken(String token) async {
    await _initPreferences();
    await _sharedPreferences?.setString(_tokenKey, token);
  }

  // Retrieves the token from shared preferences
  Future<String?> getToken() async {
    await _initPreferences();
    return _sharedPreferences?.getString(_tokenKey);
  }

  // Removes the token from shared preferences (for logout)
  Future<void> removeToken() async {
    await _initPreferences();
    await _sharedPreferences?.remove(_tokenKey);
  }

  // Checks if a token exists in shared preferences
  Future<bool> hasToken() async {
    await _initPreferences();
    return _sharedPreferences?.containsKey(_tokenKey) ?? false;
  }
}
