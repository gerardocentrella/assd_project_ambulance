class LoginController {

  late int _code;

  Future<AuthEnum> login(String ambulanceId, String password) async {
    _code = 200; /* modificare con una chiamata restful al server*/
    if (_code == 200) {
      return AuthEnum.success;
    }
    else {
      return AuthEnum.invalidCredentials;
    }
  }

}

// auth enum
enum AuthEnum {
  success,
  invalidCredentials,
  networkError,
  unexpectedError,
}