// blocs/emergency_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';

import 'emegency_event.dart';
import 'emergency_state.dart';

class EmergencyBloc extends Bloc<EmergencyEvent, EmergencyState> {
  EmergencyBloc() : super(EmergencyInitial()) {
    on<EmergencyReceived>((event, emit) async {
      emit(EmergencyLoading());

      try {
        // Simulazione di un caricamento riuscito
        await Future.delayed(const Duration(seconds: 1)); // Simula un caricamento
        emit(EmergencyLoaded(event.emergency));
      } catch (e) {
        emit(EmergencyError(e.toString()));
      }
    });

    on<EmergencyEnded>((event, emit) {
      emit(EmergencyInitial()); // Ripristina lo stato iniziale dopo che l'emergenza è terminata
    });
  }
}