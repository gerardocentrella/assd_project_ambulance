
/*
The AuthenticationRepository exposes a Stream of AuthenticationStatus
updates which will be used to notify the application when a user signs in or out.
 */
import 'dart:async';

import 'package:assd_project_ambulance/controllers/services/HttpResult.dart';
import 'package:assd_project_ambulance/controllers/services/login_service.dart';
import 'package:assd_project_ambulance/models/repository/user_repository.dart';

import '../entities/User.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

class AuthenticationRepository {

  final _controller = StreamController<AuthenticationStatus>();
  final httpService = LoginService();
  final UserRepository userRepository = UserRepository();

  Stream<AuthenticationStatus> get status async* {
    await Future<void>.delayed(const Duration(seconds: 1));
    yield AuthenticationStatus.unauthenticated;
    yield* _controller.stream;
  }

  Future<void> logIn({
    required String username,
    required String password,
  }) async {
    try {
      // Chiama il service specico per effettuare la chiamata API di login
      HttpResult<String> result = await httpService.signIn(username, password);

      if (result.httpStatusCode == 201 && result.data != null) {
        String token = result.data!;

        // Crea un nuovo utente e memorizzalo nel UserRepository
        //await userRepository.fetchUser(token);

        // Aggiungi lo stato autenticato al stream
        await Future.delayed(const Duration(milliseconds: 300),
              () => _controller.add(AuthenticationStatus.authenticated),
        );
      } else {
        _controller.add(AuthenticationStatus.unauthenticated);
      }
    } catch (e) {
      // Gestisci errori
      _controller.add(AuthenticationStatus.unauthenticated);
    }

  }
  void logOut() {
    // Rimuovi l'utente dal UserRepository
    userRepository.removeUser();
    _controller.add(AuthenticationStatus.unauthenticated);
  }

  void dispose() => _controller.close();
}