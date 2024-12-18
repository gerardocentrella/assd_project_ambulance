import 'dart:convert';

import 'package:assd_project_ambulance/utils/http_result.dart';
import 'package:assd_project_ambulance/models/dto/PathDTO.dart';
import 'package:assd_project_ambulance/models/dto/PatientReachedNotificationDTO.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/repository/token_repository.dart';

class PatientReachedService {
  final TokenRepository _tokenRepository;

  PatientReachedService(this._tokenRepository);


  Future<HttpResult<String>> sendPatientReachedNotification2(
      PatientReachedNotificationDTO dataToSend, String emergencyId) async {
    // Recupera il token da SharedPreferences
    String? token = await _tokenRepository.getToken();

    print("Sono in PatientReachedService");

    final url =
    Uri.parse('http://172.31.4.63:32225/emergencyService/emergencies/$emergencyId');
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final body = jsonEncode(dataToSend);

    try {
      final response = await http.patch(url, headers: headers, body: body);
      return _handleResponse(response);
    } catch (e) {
      return _handleException(e);
    }
  }

  HttpResult<String> _handleResponse(http.Response response) {
    if (response.statusCode == 200) {
      /*return HttpResult<PathDTO>(
          data: PathDTO.fromJson(
              jsonDecode(response.body) as Map<String, dynamic>),
          httpStatusCode: 200);*/
      return HttpResult<String>(
        data: response.body,
          httpStatusCode: 200
      );
    } else {
      // Gestisci gli errori HTTP con il tuo metodo
      return HttpResult<String>(
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
        return 'Update Notification Failed. Status code: $statusCode';
    }
  }

  HttpResult<String> _handleException(dynamic e) {
    if (e is http.ClientException) {
      return HttpResult<String>(
          httpStatusCode: 0,
          error: 'Network error: ${e.message}');
    } else {
      return HttpResult<String>(
          httpStatusCode: -1, // Unknown errors
          error: 'An unknown error occurred: ${e.toString()}');
    }
  }
}
