import 'dart:convert';

import 'package:assd_project_ambulance/controllers/services/HttpResult.dart';
import 'package:assd_project_ambulance/models/dto/PathDTO.dart';
import 'package:assd_project_ambulance/models/dto/PatientReachedNotificationDTO.dart';
import 'package:assd_project_ambulance/models/entities/Position.dart';
import 'package:http/http.dart' as http;

class PatientReachedService {
  PatientReachedService();

  // secondo approccio
  Future<List<Position>> sendPatientReached(
      PatientReachedNotificationDTO dataToSend) async {
    List<Position> positions = [];

    final url = Uri.parse('http://example.com/api/endpoint');
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode(dataToSend);

    final response = await http.patch(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      var responseBody = jsonDecode(response.body) as List;
      for (var item in responseBody) {
        positions.add(Position.fromJson(item as Map<String, dynamic>));
      }
      return positions;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to update album.');
    }
  }

  // terzo approccio
  Future<HttpResult<PathDTO>> sendPatientReachedNotification2(
      PatientReachedNotificationDTO dataToSend, String emergencyId) async {
    final url = Uri.parse('http://example.com/api/endpoint/emergencies/$emergencyId');
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    };
    final body = jsonEncode(dataToSend);

    final response = await http.patch(url, headers: headers, body: body);
print(" sono nel servizio ");
    try {
      if (response.statusCode == 200) {
        return HttpResult<PathDTO>(
            data: PathDTO.fromJson(
                jsonDecode(response.body) as Map<String, dynamic>),
            httpStatusCode: 200);
      } else {
        return HttpResult<PathDTO>(
            httpStatusCode: response.statusCode,
            error: 'Failed to update. Status code: ${response.statusCode}');
      }
    } catch (e) {
      if (e is http.ClientException) {
        return HttpResult<PathDTO>(
            httpStatusCode: 0,
            // Client level error
            error: 'Network error: ${e.message}');
      } else {
        return HttpResult<PathDTO>(
            httpStatusCode: -1, // Unknown error
            error: 'An unknown error occurred: ${e.toString()}');
      }
    }
  }
}
