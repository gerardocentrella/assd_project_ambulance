import 'package:assd_project_ambulance/controllers/services/HttpResult.dart';
import 'package:http/http.dart' as http;

class EmergencyRoomReachedService {
  Future<HttpResult> sendEmergencyRoomReached(String emergencyId) async {

    final url =
    Uri.parse('http://example.com/api/endpoint/emergencies/$emergencyId/status');
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    };

    final response = await http.post(url, headers: headers);

    try {
      if (response.statusCode == 200) {
        // If the server did return a 200 CREATED response,
        // then parse the JSON.

        return HttpResult(httpStatusCode: 200);
      } else {
        // If the server did not return a 200 CREATED response,
        // then throw an exception.
        return HttpResult(
            httpStatusCode: response.statusCode,
            error: 'Emergency Room Reached Notify Failed. Status code: ${response.statusCode}');
      }
    } catch (e) {
      if (e is http.ClientException) {
        return HttpResult(
            httpStatusCode: 0,
            // Client level fail
            error: 'Network error: ${e.message}');
      } else {
        return HttpResult(
            httpStatusCode: -1, // Unknown errors
            error: 'An unknown error occurred: ${e.toString()}');
      }
    }

  }
}
