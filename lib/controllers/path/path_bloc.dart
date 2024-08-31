// blocs/path_bloc.dart
import 'package:assd_project_ambulance/controllers/gps/gps_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../controllers/message_controller.dart';
import '../../models/dto/PathDTO.dart';
import '../../models/entities/Position.dart';
import '../../models/repository/ambulance_repository.dart';
import 'path_event.dart';
import 'path_state.dart';

class PathBloc extends Bloc<PathEvent, PathState> {
  final MessageController _messageController;
  final AmbulanceIdRepository _ambulanceIdRepository;
  String? ambulanceId;


  PathBloc(this._messageController, this._ambulanceIdRepository) : super(PathInitial()) {
    _initialize(); // inizializzazione stream e ascolto

    on<PathReceived>((event, emit) {
      emit(PathProcessing(event.path));

    });

    on<PathEnded>((event, emit) {
      emit(PathListening()); // Ritorna allo stato di ascolto
    });
  }

  Future<void> _initialize() async {
    try {
      // Recupera l'ID dell'ambulanza
      await _ambulanceIdRepository.saveAmbulanceId("AMB00001");
      ambulanceId = await _ambulanceIdRepository.getAmbulanceId();
      if (ambulanceId == null) {
        emit(const PathError('Ambulance ID not found'));
        return;
      }

      // Procedi con l'inizializzazione ora che l'ID è stato recuperato
      _initializeStreams();
      // simulazione ricezione path
      _simulatePathReceiving();
    } catch (e) {
      emit(PathError(e.toString()));
    }
  }

  String get pathURL {
    if (ambulanceId != null) {
      return 'ws://172.31.4.63:30202/pathNotifier/websocket/ambulances/$ambulanceId/path';
    }
    throw Exception('Ambulance ID is not initialized');
  }

  void _initializeStreams() {
    // Apro stream per percorsi
    _messageController.openPathStream(pathURL);

    // Ascolta lo stream dei percorsi
    _messageController.pathStream.listen((path) {
      add(PathReceived(path));

    });
  }

  // Funzione di simulazione di ricezione del percorso
  void _simulatePathReceiving() {
    print("Simulazione di ricezione del percorso avviata...");
    // Simula la ricezione di un percorso dopo 5 secondi
    Future.delayed(const Duration(seconds: 5), () {
      print("Percorso ricevuto!");

      // Creiamo una lista di oggetti Position da usare nel PathDTO
      List<Position> simulatedPath = [
        Position(latitude: 45.1, longitude: 9.1), // Punto 1
        Position(latitude: 45.2, longitude: 9.2), // Punto 2
        Position(latitude: 45.3, longitude: 9.3), // Punto 3
        // Aggiungere altri punti se necessario
      ];

      // Crea il PathDTO utilizzando la lista simulata
      PathDTO pathDTO = PathDTO(simulatedPath);

      // Invia l'evento PathReceived al bloc all'atto della ricezione del percorso
      add(PathReceived(pathDTO));
    });
  }
}