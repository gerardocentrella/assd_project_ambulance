
import 'dart:async';
import 'dart:convert';

import 'package:assd_project_ambulance/models/dto/EmergencyDTO.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../../models/dto/PathDTO.dart';
/*
La classe WebSocketManager gestisce le connessioni WebSocket in un'applicazione Dart.
Funziona come un service per stabilire e mantenere una comunicazione in tempo reale, attraverso un protocollo di comunicazione
full-duplex. Si prevede impiego di StreamControllers per gestire stream di dati con il tipo EmergencyDTO e PathDTO.
Tramite questi stream controller è possibile ricevere i messaggi.
Gli oggetti/messaggi verranno deserializzati tramite apposita callback di deserializzazione(fromJson) e in seguito
aggiunti ai rispettivi stream controller da cui sarà possibile prelevarli.
Questa classe non viene impiegata direttamente: funge da service per interoperare con la CO remota ma viene adoperata da uno
specifico controller dei messaggi.
 */

class WebSocketManager {
  late WebSocketChannel channelEm;
  late WebSocketChannel channelPath;

  late StreamController<EmergencyDTO> _streamEmergencyController =
  StreamController.broadcast();
  late StreamController<PathDTO> _streamPathController =
  StreamController.broadcast();


  // Getter per stream controllers
  StreamController<EmergencyDTO> get streamEmergencyController =>
      _streamEmergencyController;

  StreamController<PathDTO> get streamPathController => _streamPathController;

  WebSocketManager();

  // metodo per chiudere il canale
  void close() {
    print(" Sono in close:::::::::::::channelEM:::::::::::::::::::..");
    print(channelEm);
    channelEm.sink.close();
    channelPath.sink.close();
    // aggiunta chiusura stream controllers
    _streamPathController.close();
    _streamEmergencyController.close();

  }

 /* Future<void> _openStream(
      String url, Function fromJson, StreamController streamController, WebSocketChannel channel) async {

    if(streamController.isClosed) {
      print("///////////////////////////////////////////////////////////// STREAM CONTROLLER CHIUSO: RIAPRO ////////////////////////////////////////////////////////////////////");
      streamController = StreamController<dynamic>.broadcast();
    }

    print("SONO NELLA FUNZIONE DI OPENSTREAM PRIMA DI CONNECT__________________________________________________________________________");
    channel = WebSocketChannel.connect(Uri.parse(url));
    print("SONO NELLA FUNZIONE OPENSTREAM DOPO CONNECT DI WEBSOCKET MANAGER__________________________________________________________________________");
    print("channel");print(channel);print(channelEm);
    await channel.ready;
    print("CANALE PRONTOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO");

    channel.stream.listen((message) {
      print("Messaggio ricevuto dal WebSocket-----------------------------------------------------------------------------------: $message"); // Verifica il formato del messaggio
      try {
        Map<String, dynamic> jsonMessage = jsonDecode(message);
        print("SONO IN WEBSOCKET MANAGER LISTEN:___________________________________________________________Messaggio ricevuto: $jsonMessage");
        var msg = fromJson(jsonMessage);
        streamController.add(msg);
      } catch (e) {
        print('Error parsing JSON: $e');
      }
    }, onDone: () {
      Future.delayed(const Duration(seconds: 5),
              () => _openStream(url, fromJson, streamController, channel));
    }, onError: (error) {
      print('WebSocket error: $error');
      Future.delayed(const Duration(seconds: 5),
              () => _openStream(url, fromJson, streamController, channel));
    });
  }*/

  // metodo per richiedere alla CO l'apertura di un canale full-duplex per ricevere gli update dell'emergenza
  Future<void> openEmergencyUpdateStream(String url) async {
    print("SONO IN APERTURA CANALE DI WEBSOCKET MANAGER PRIMA DI OPEN STREAM__________________________________________________________________________");
    //await _openStream(url, EmergencyDTO.fromJson, _streamEmergencyController, channelEm);
    if(_streamEmergencyController.isClosed) {
      print("///////////////////////////////////////////////////////////// STREAM CONTROLLER CHIUSO: RIAPRO ////////////////////////////////////////////////////////////////////");
      _streamEmergencyController = StreamController<EmergencyDTO>.broadcast();
    }

    print("SONO NELLA FUNZIONE DI OPENSTREAM PRIMA DI CONNECT__________________________________________________________________________");
    channelEm = WebSocketChannel.connect(Uri.parse(url));
    print("SONO NELLA FUNZIONE OPENSTREAM DOPO CONNECT DI WEBSOCKET MANAGER__________________________________________________________________________");
    print("channel");print(channelEm);print(channelEm);
    await channelEm.ready;
    print("CANALE PRONTOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO");

    channelEm.stream.listen((message) {
      print("Messaggio ricevuto dal WebSocket-----------------------------------------------------------------------------------: $message"); // Verifica il formato del messaggio
      try {
        Map<String, dynamic> jsonMessage = jsonDecode(message);
        print("SONO IN WEBSOCKET MANAGER LISTEN:___________________________________________________________Messaggio ricevuto: $jsonMessage");
        var msg = EmergencyDTO.fromJson(jsonMessage);
        _streamEmergencyController.add(msg);
      } catch (e) {
        print('Error parsing JSON: $e');
      }
    });
  print("SONO IN APERTURA CANALE DI WEBSOCKET MANAGER DOPO DI OPEN STREAM__________________________________________________________________________");
  }

  // metodo per richiedere alla CO apertura canale full-duplex per ricevere update sul path da seguire
  // sia verso il paziente sia verso il PS
  Future<void> openPathUpdateStream(String url) async {
    //await openEmergencyUpdateStream(url, PathDTO.fromJson, _streamPathController, channelPath);
    if(_streamPathController.isClosed) {
      print("///////////////////////////////////////////////////////////// STREAM CONTROLLER CHIUSO: RIAPRO ////////////////////////////////////////////////////////////////////");
      _streamPathController = StreamController<PathDTO>.broadcast();
    }

    print("SONO NELLA FUNZIONE DI OPENSTREAM PRIMA DI CONNECT__________________________________________________________________________");
    channelPath = WebSocketChannel.connect(Uri.parse(url));
    print("SONO NELLA FUNZIONE OPENSTREAM DOPO CONNECT DI WEBSOCKET MANAGER__________________________________________________________________________");
    print("channel");print(channelPath);print(channelEm);
    await channelPath.ready;
    print("CANALE PRONTOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO");

    channelPath.stream.listen((message) {
      print("Messaggio ricevuto dal WebSocket-----------------------------------------------------------------------------------: $message"); // Verifica il formato del messaggio
      try {
        Map<String, dynamic> jsonMessage = jsonDecode(message);
        print("SONO IN WEBSOCKET MANAGER LISTEN:___________________________________________________________Messaggio ricevuto: $jsonMessage");
        var msg = PathDTO.fromJson(jsonMessage);
        _streamPathController.add(msg);
      } catch (e) {
        print('Error parsing JSON: $e');
      }
    });
  }
}