import 'dart:async';

import 'package:assd_project_ambulance/controllers/services/websocket_manager.dart';

import '../models/dto/EmergencyDTO.dart';
import '../models/dto/PathDTO.dart';

class MessageController {
  final WebSocketManager _webSocketManager;
  final StreamController<EmergencyDTO> _emergencyStreamController = StreamController.broadcast();
  final StreamController<PathDTO> _pathStreamController = StreamController.broadcast();

  MessageController(this._webSocketManager) {
    // Ascolta i flussi del WebSocketManager
    _webSocketManager.openEmergencyUpdateStream().then((_) {
      _webSocketManager.streamEmergencyController.stream.listen((emergency) {
        _emergencyStreamController.add(emergency);
      });
    });

    _webSocketManager.openPathUpdateStream().then((_) {
      _webSocketManager.streamPathController.stream.listen((path) {
        _pathStreamController.add(path);
      });
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



