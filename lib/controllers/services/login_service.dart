import 'dart:convert';

import 'package:assd_project_ambulance/utils/http_result.dart';
import 'package:http/http.dart' as http;

class LoginService {
  Future<HttpResult<String>> signIn(String userId, String password) async {
    final url =
        Uri.parse('http://example.com/api/endpoint/users/$userId/sessions');
    final headers = {
      'Content-Type': 'text/plain',
      //'Accept': 'application/json'
    };
    //final body = jsonEncode(<String, String>{'password': password});
    final body = password;

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {

        //final data = jsonDecode(response.body);
        //String token = data['token'];
        String token = response.body;
        return HttpResult<String>(data: token, httpStatusCode: 200);
      } else {
        // Additional error handling based on status code
        return HttpResult<String>(
            httpStatusCode: response.statusCode,
            error: _handleHttpError(response.statusCode));
      }
    } catch (e) {
      return _handleException(e);
    }
  }

  String _handleHttpError(int statusCode) {
    switch (statusCode) {
      case 400:
        return 'Bad Request. Please check your data.';
      case 401:
        return 'Unauthorized. Incorrect login credentials.';
      case 500:
        return 'Internal Server Error. Please try again later.';
      default:
        return 'Login Failed. Status code: $statusCode';
    }
  }

  HttpResult<String> _handleException(dynamic e) {
    if (e is http.ClientException) {
      return HttpResult<String>(
          httpStatusCode: 0, error: 'Network error: ${e.message}');
    } else {
      return HttpResult<String>(
          httpStatusCode: -1, // Unknown errors
          error: 'An unknown error occurred: ${e.toString()}');
    }
  }
}
