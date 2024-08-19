class LoginController {

  late int _code;

  bool login(String ambulanceId, String password) {

    // invocazione metodo specifico di login del servizio RESTFul
    if(/*_code == 200*/ true) {
      // successo --> LOGIN

      return true;
    } else {
      // errore
      return false;
    }

  }
}