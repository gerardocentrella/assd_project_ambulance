import 'dart:async';
import 'dart:convert';

import 'package:assd_project_ambulance/models/dto/EmergencyDTO.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../../models/dto/PathDTO.dart';

class WebSocketManager {
  late WebSocketChannel channel;
  final StreamController<EmergencyDTO> _streamEmergencyController =
      StreamController.broadcast();
  final StreamController<PathDTO> _streamPathController =
      StreamController.broadcast();

  // Getter per stream controllers
  StreamController<EmergencyDTO> get streamEmergencyController =>
      _streamEmergencyController;

  StreamController<PathDTO> get streamPathController => _streamPathController;

  WebSocketManager();

  // metodo per chiudere il canale
  void close() {
    channel.sink.close();
  }

  Future<void> _openStream(
      String url, Function fromJson, StreamController streamController) async {
    channel = WebSocketChannel.connect(Uri.parse(url));

    await channel.ready;

    channel.stream.listen((message) {
      try {
        Map<String, dynamic> jsonMessage = jsonDecode(message);
        var msg = fromJson(jsonMessage);
        streamController.add(msg);
      } catch (e) {
        print('Error parsing JSON: $e');
      }
    }, onDone: () {
      Future.delayed(const Duration(seconds: 5),
          () => _openStream(url, fromJson, streamController));
    }, onError: (error) {
      print('WebSocket error: $error');
      Future.delayed(const Duration(seconds: 5),
          () => _openStream(url, fromJson, streamController));
    });
  }

  // metodo per richiedere alla CO l'apertura di un canale full-duplex per ricevere gli update dell'emergenza
  Future<void> openEmergencyUpdateStream(String url) async {
    await _openStream(url, EmergencyDTO.fromJson, _streamEmergencyController);
  }

  // metodo per richiedere alla CO apertura canale full-duplex per ricevere update sul path da seguire
  // sia verso il paziente sia verso il PS
  Future<void> openPathUpdateStream(String url) async {
    await _openStream(url, PathDTO.fromJson, _streamPathController);
  }
}
