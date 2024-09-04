import 'dart:async';

import 'package:assd_project_ambulance/controllers/emergency/emegency_event.dart';
import 'package:assd_project_ambulance/controllers/gps/gps_bloc.dart';
import 'package:assd_project_ambulance/controllers/message_controller.dart';
import 'package:assd_project_ambulance/models/entities/Emergency.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/repository/authentication_repository.dart';
import '../../../models/repository/token_repository.dart';
import '../../emergency/emergency_bloc.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthenticationBloc extends Bloc<AuthEvent, AuthState> {
  AuthenticationBloc({
    required AuthenticationRepository authenticationRepository,
    required TokenRepository tokenRepository,
    required MessageController messageController,
    required GpsBloc gpsBloc,
    required EmergencyBloc emergencyBloc,
  })  : _authenticationRepository = authenticationRepository,
        _tokenRepository = tokenRepository,
        _messageController = messageController,
        _gpsBloc = gpsBloc,
        _emergencyBloc = emergencyBloc,
        super(const AuthState.unknown()) {
    on<AuthenticationSubscriptionRequested>(_onSubscriptionRequested);
    on<AuthenticationLogoutPressed>(_onLogoutPressed);
  }

  final AuthenticationRepository _authenticationRepository;
  final TokenRepository _tokenRepository;
  final MessageController _messageController;

  final EmergencyBloc _emergencyBloc;
  final GpsBloc _gpsBloc;

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
            final token = await _tryGetToken();
            if(token != null)
              {
                _emergencyBloc.add(EmergencyInitialization());
                _gpsBloc.add(GpsInitialization());
                return emit(AuthState.authenticated(token));
              }else{
              return emit(const AuthState.unauthenticated());
            }
           /* return emit(
              token != null
                  ? AuthState.authenticated(token)
                  : const AuthState.unauthenticated(),
            );*/
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
    // provare chiusura dei canali
    _messageController.dispose();
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
