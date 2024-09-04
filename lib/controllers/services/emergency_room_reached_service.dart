import 'package:assd_project_ambulance/utils/http_result.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/repository/token_repository.dart';

class EmergencyRoomReachedService {
  final TokenRepository _tokenRepository; // Aggiungi una proprietà private

  EmergencyRoomReachedService(this._tokenRepository); // Inietta il TokenRepositor

  Future<HttpResult> sendEmergencyRoomReachedNotification(
      String emergencyId) async {
    // Recupera il token da SharedPreferences tramite apposito repository

    //SharedPreferences prefs = await SharedPreferences.getInstance();
    //String? token = prefs.getString('user_token');
    String? token = await _tokenRepository.getToken();

    final url = Uri.parse(
        'http://172.31.4.63:32225/emergencyService/emergencies/$emergencyId/status');
    final headers = {
      'Accept': '*/*',
      'Authorization': 'Bearer $token',
    };

    try {
      final response = await http.patch(url, headers: headers);
      return _handleResponse(response);
    } catch (e) {
      return _handleException(e);
    }
  }

  HttpResult _handleResponse(http.Response response) {
    if (response.statusCode == 200) {
      return HttpResult(httpStatusCode: 200);
    } else {
      // Additional error handling based on status code
      return HttpResult(
          httpStatusCode: response.statusCode,
          error: _handleHttpError(response.statusCode));
    }
  }

  String _handleHttpError(int statusCode) {
    switch (statusCode) {
      case 400:
        return 'Bad Request. Please check your request data.';
      case 401:
        return 'Unauthorized. Please check your authentication.';
      case 404:
        return 'Not Found. Emergency not found.';
      case 500:
        return 'Internal Server Error. Please try again later.';
      default:
        return 'Emergency Room Reached Notification Failed. Status code: $statusCode';
    }
  }

  HttpResult _handleException(dynamic e) {
    if (e is http.ClientException) {
      return HttpResult(
          httpStatusCode: 0, error: 'Network error: ${e.message}');
    } else {
      return HttpResult(
          httpStatusCode: -1, // Unknown errors
          error: 'An unknown error occurred: ${e.toString()}');
    }
  }
}
