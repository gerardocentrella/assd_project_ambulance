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
    _initialize();

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

  Future<void> _initialize() async {
    try {
      // Recupera l'ID dell'ambulanza
      await _ambulanceIdRepository.saveAmbulanceId("AMB00001");
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
    print(
        "ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff");
    _messageController
        .openEmergencyStream("ws://10.0.2.2:8765/emergencyNotifier");
    print(
        "dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd");
    // Ascolta lo stream delle emergenze
    _messageController.emergencyStream.listen((emergency) {
      print("Emergency: $emergency");
      add(EmergencyReceived(emergency));

    });
  }

  // Funzione di simulazione d'emergenza
  void _simulateEmergencyReceiving() {
    print(
        "HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH");
    // Simula la ricezione di un'emergenza dopo 2 secondi
    Future.delayed(const Duration(seconds: 5), () {
      print(
          "SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS");
      EmergencyDTO emergency = EmergencyDTO(
        emergency: Emergency(
          id: '12345',
          userPosition: Position(latitude: 45.0, longitude: 9.0),
          emergencyCode: EmergencyCode.WHITE,
          description: 'Boh!!.',
          emergencyStatus: EmergencyStatus.ER_SELECTED,
          emergencyType: EmergencyType.C19_ALTRA_PATOLOGIA,
          ambulanceId: 'AMB',
          erId: '001',
        ),
      );
      // Invia gli eventi al bloc all'atto della ricezione dell'emergenza.
      add(EmergencyReceived(emergency));
    });
  }
}
