
import 'dart:async';

import 'package:assd_project_ambulance/controllers/services/websocket_manager.dart';
import '../models/dto/EmergencyDTO.dart';
import '../models/dto/PathDTO.dart';

/*
La classe MessageController che hai fornito funge da intermediario tra la gestione dei dati ricevuti tramite WebSocket e le parti
della tua applicazione che necessitano di questi dati (come ad esempio i widget dell'interfaccia utente).
Specificatamente questa classe funge da intermediario tra i bloc reponsabili di gestire la logica di business che guida
gli aggiornamenti delle view, e il manager/service delle WebSocket.
Classe wrapper incapsulante quel codice specifico della logica di business per gestire l'impiego del manager.
Questa classe organizza la gestione degli aggiornamenti delle emergenze e dei percorsi, utilizzando un'istanza di WebSocketManager
per stabilire connessioni e ascoltare gli stream di dati.
 */

class MessageController {
  final WebSocketManager _webSocketManager;
  StreamController<EmergencyDTO> _emergencyStreamController = StreamController.broadcast();
  StreamController<PathDTO> _pathStreamController = StreamController.broadcast();

  MessageController(this._webSocketManager);

  // Metodo per aprire il flusso di aggiornamento delle emergenze
  Future<void> openEmergencyStream(String emergencyUrl) async {
    if(_emergencyStreamController.isClosed) {
      _emergencyStreamController = StreamController.broadcast();
    }
    print("SONO IN MESSAGE CONTROLLER_____________________________________________________________________________________________");
    await _webSocketManager.openEmergencyUpdateStream(emergencyUrl);
    _webSocketManager.streamEmergencyController.stream.listen((emergency) {
      print("SONO IN MESSAGE CONTROLLER NEL LISTEN________________________________________________________________________________");
      _emergencyStreamController.add(emergency);
    });
  }

  // Metodo per aprire il flusso di aggiornamento dei percorsi
  Future<void> openPathStream(String pathUrl) async {
    if(_pathStreamController.isClosed) {
      _pathStreamController = StreamController.broadcast();
    }
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

    // aggiunta chiusura canale websocket
    _webSocketManager.close();
  }
}