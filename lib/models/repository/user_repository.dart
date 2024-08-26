import 'dart:async';

import 'package:assd_project_ambulance/models/entities/User.dart';

//forse inutile

class UserRepository {
  User? _user;

  // Fetches the user based on the provided token
  Future<User?> fetchUser(String token) async {
    // Recupero dell'utente
    return Future.delayed(
      const Duration(milliseconds: 300),
      () {
        // Salviamo l'utente
        _user = User(token);
        return _user;
      },
    );
  }

  // Removes the user (for logout)
  void removeUser() {
    _user = null;
  }

  // Optional: metodo per restituire l'utente attualmente autenticato
  User? get currentUser => _user;

  // Optional: verifica se l'utente è autenticato
  bool get isAuthenticated => _user != null;
}
