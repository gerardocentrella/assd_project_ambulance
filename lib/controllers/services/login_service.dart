import 'dart:convert';

import 'package:assd_project_ambulance/controllers/services/HttpResult.dart';
import 'package:http/http.dart' as http;

class LoginService {
  LoginService();

  Future<HttpResult<String>> signIn(String userId, String password) async {
    final url =
        Uri.parse('http://example.com/api/endpoint/users/$userId/sessions');
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    };
    final body = jsonEncode(<String, String>{'password': password});

    final response = await http.post(url, headers: headers, body: body);

    try {
      if (response.statusCode == 201) {
        // If the server did return a 201 CREATED response,
        // then parse the JSON.
        final data = jsonDecode(response.body);
        String token = data['token'];
        return HttpResult<String>(data: token, httpStatusCode: 201);
      } else {
        // If the server did not return a 201 CREATED response,
        // then throw an exception.
        return HttpResult<String>(
            httpStatusCode: response.statusCode,
            error: 'Login Failed. Status code: ${response.statusCode}');
      }
    } catch (e) {
      if (e is http.ClientException) {
        return HttpResult<String>(
            httpStatusCode: 0,
            // Client level fail
            error: 'Network error: ${e.message}');
      } else {
        return HttpResult<String>(
            httpStatusCode: -1, // Unknown errors
            error: 'An unknown error occurred: ${e.toString()}');
      }
    }
  }
}
