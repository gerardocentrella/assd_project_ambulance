import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../models/repository/authentication_repository.dart';
import '../../../models/repository/token_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';


class AuthenticationBloc extends Bloc<AuthEvent, AuthState> {

  AuthenticationBloc({
    required AuthenticationRepository authenticationRepository,
    required TokenRepository tokenRepository,
  })  : _authenticationRepository = authenticationRepository,
        _tokenRepository = tokenRepository,
        super(const AuthState.unknown()) {
    on<AuthenticationSubscriptionRequested>(_onSubscriptionRequested);
    on<AuthenticationLogoutPressed>(_onLogoutPressed);
  }

  final AuthenticationRepository _authenticationRepository;
  final TokenRepository _tokenRepository;

  Future<void> _onSubscriptionRequested(
      AuthenticationSubscriptionRequested event,
      Emitter<AuthState> emit,
      ) {
    return emit.onEach(
      _authenticationRepository.status,
      onData: (status) async {
        switch (status) {
          case AuthenticationStatus.unauthenticated:
            return emit(const AuthState.unauthenticated());
          case AuthenticationStatus.authenticated:

            // cambiare qui per effettuare la chiamata
            //final token = await _tryGetToken();

            const token = "prova";
            return emit(
              token != null
                  ? AuthState.authenticated(token)
                  : const AuthState.unauthenticated(),
            );

          case AuthenticationStatus.unknown:
            return emit(const AuthState.unknown());
        }
      },
      onError: addError,
    );
  }

  void _onLogoutPressed(
      AuthenticationLogoutPressed event,
      Emitter<AuthState> emit,
      ) {
    _authenticationRepository.logOut();
  }

  Future<String?> _tryGetToken() async {
    try {
      final token = await _tokenRepository.getToken();
      return token;
    } catch (_) {
      return null;
    }
  }
}