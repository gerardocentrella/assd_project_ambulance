import 'dart:convert';

import 'package:assd_project_ambulance/models/dto/PathDTO.dart';
import 'package:assd_project_ambulance/models/dto/PatientReachedNotificationDTO.dart';
import 'package:assd_project_ambulance/models/entities/Position.dart';
import 'package:http/http.dart' as http;

class PatientReachedService {

  // primo approccio
  Future<PathDTO> sendPatientReachedNotification(
      PatientReachedNotificationDTO dataToSend) async {
    final url = Uri.parse('http://example.com/api/endpoint');
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode(dataToSend);

    final response = await http.patch(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return PathDTO.fromJson(
          jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to update album.');
    }
  }
/*
  // secondo approccio
  Future<List<Position>> sendPatientReached(
      PatientReachedNotificationDTO dataToSend) async {
    List<Position> positions = [];

    final url = Uri.parse('http://example.com/api/endpoint');
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode(dataToSend);

  }

 */
}
