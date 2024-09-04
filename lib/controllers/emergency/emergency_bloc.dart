// blocs/emergency_bloc.dart
/*
import 'package:assd_project_ambulance/models/repository/emergency_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'emegency_event.dart';
import 'emergency_state.dart';

class EmergencyBloc extends Bloc<EmergencyEvent, EmergencyState> {
  
  EmergencyBloc() : super(EmergencyListening()) {
    on<EmergencyReceived>((event, emit) async {
      //emit(EmergencyLoading());

      try {
        // Simulazione di un caricamento riuscito
        await Future.delayed(const Duration(seconds: 1)); // Simula un caricamento
        emit(EmergencyProcessing(event.emergency));
      } catch (e) {
        emit(EmergencyError(e.toString()));
      }
    });

    on<EmergencyEnded>((event, emit) {
      emit(EmergencyListening()); // Ripristina lo stato iniziale dopo che l'emergenza è terminata
    });
  }
}

 */

// bloc/emergency_bloc.dart
import 'package:assd_project_ambulance/models/repository/ambulanceId_repository.dart';
import 'package:assd_project_ambulance/models/repository/emergencyId_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/entities/Emergency.dart';
import '../../models/entities/Position.dart';
import 'emegency_event.dart';
import 'emergency_state.dart'; // Importa il file degli stati
import '../../models/dto/EmergencyDTO.dart';
import '../../controllers/message_controller.dart';

class EmergencyBloc extends Bloc<EmergencyEvent, EmergencyState> {
  final MessageController _messageController;
  final AmbulanceIdRepository _ambulanceIdRepository;
  // aggiunta repository
  final EmergencyIdRepository _emergencyIdRepository;
  String? ambulanceId;

  //static const ambulanceId = "AMB00001";

  EmergencyBloc(this._messageController, this._ambulanceIdRepository, this._emergencyIdRepository)
      : super(EmergencyInitial()) {
    // Inizializzazione e ascolto dello stream

    on<EmergencyInitialization>((event, emit) async{
      await _initialize(emit);
    });

    on<EmergencyReceived>((event, emit) async {
      emit(EmergencyProcessing(event.emergency));

      // Memorizza l'emergencyId
      await _emergencyIdRepository.saveEmergencyId(event.emergency.id); // Salva l'emergencyId

    });

    // Gestore per l'evento EmergencyEnded
    on<EmergencyEnded>((event, emit) async {
      try {
        // Rimuovi emergencyId dalle shared preferences
        await _emergencyIdRepository.removeEmergencyId();

        emit(EmergencyListening()); // Ritorna allo stato di ascolto
      } catch (e) {
        emit(EmergencyError(e.toString())); // Gestisci eventuali errori
      }
    });
  }

  Future<void> _initialize(Emitter<EmergencyState> emit) async {
    try {
      // Recupera l'ID dell'ambulanza
      ambulanceId = await _ambulanceIdRepository.getAmbulanceId();
      if (ambulanceId == null) {
        emit(const EmergencyError('Ambulance ID not found'));
        return;
      }

      // Procedi con l'inizializzazione ora che l'ID è stato recuperato
      _initializeStreams();
      //_simulateEmergencyReceiving();
    } catch (e) {
      emit(EmergencyError(e.toString()));
    }
  }

  // Metodi per costruire gli URL
  String get emergencyURL {
    if (ambulanceId != null) {
      return 'ws://172.31.4.63:31656/emergencyNotifier/websocket/ambulances/$ambulanceId/emergencies';
    }
    throw Exception('Ambulance ID is not initialized');
  }

  void _initializeStreams() {
    // Apro stream per emergenze
      _messageController
        .openEmergencyStream(emergencyURL);
      // Ascolta lo stream delle emergenze
    _messageController.emergencyStream.listen((emergency) {
      print("Emergency: $emergency");
      add(EmergencyReceived(emergency));

    });
  }
}
