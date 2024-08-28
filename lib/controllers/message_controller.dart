import 'dart:async';

import 'package:assd_project_ambulance/controllers/services/websocket_manager.dart';
import '../models/dto/EmergencyDTO.dart';
import '../models/dto/PathDTO.dart';

class MessageController {
  final WebSocketManager _webSocketManager;
  final StreamController<EmergencyDTO> _emergencyStreamController = StreamController.broadcast();
  final StreamController<PathDTO> _pathStreamController = StreamController.broadcast();

  MessageController(this._webSocketManager);

  // Metodo per aprire il flusso di aggiornamento delle emergenze
  Future<void> openEmergencyStream(String emergencyUrl) async {
    await _webSocketManager.openEmergencyUpdateStream(emergencyUrl);
    _webSocketManager.streamEmergencyController.stream.listen((emergency) {
      _emergencyStreamController.add(emergency);
    });
  }

  // Metodo per aprire il flusso di aggiornamento dei percorsi
  Future<void> openPathStream(String pathUrl) async {
    await _webSocketManager.openPathUpdateStream(pathUrl);
    _webSocketManager.streamPathController.stream.listen((path) {
      _pathStreamController.add(path);
    });
  }

  // Stream per i dati delle emergenze
  Stream<EmergencyDTO> get emergencyStream => _emergencyStreamController.stream;

  // Stream per i dati del percorso
  Stream<PathDTO> get pathStream => _pathStreamController.stream;

  void dispose() {
    _emergencyStreamController.close();
    _pathStreamController.close();
  }
}