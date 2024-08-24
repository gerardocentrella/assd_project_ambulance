import 'dart:async';
import 'dart:convert';

import 'package:assd_project_ambulance/models/dto/EmergencyDTO.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../../models/dto/PathDTO.dart';

class WebSocketManager {
  final String url;
  late WebSocketChannel channel;
  final StreamController<EmergencyDTO> _streamEmergencyController =
      StreamController.broadcast();
  final StreamController<PathDTO> _streamPathController =
      StreamController.broadcast();

  // Getter per stream controllers
  StreamController<EmergencyDTO> get streamEmergencyController => _streamEmergencyController;
  StreamController<PathDTO> get streamPathController => _streamPathController;

  //WebSocketManager();

  WebSocketManager(this.url);

  // metodo per chiudere il canale
  void close() {
    channel.sink.close();
  }

  Future<void> _openStream(String endpoint, Function fromJson,
      StreamController streamController) async {
    channel = WebSocketChannel.connect(Uri.parse(url + endpoint));

    await channel.ready;

    channel.stream.listen(
      (message) {
        try {
          Map<String, dynamic> jsonMessage = jsonDecode(message);
          var msg = fromJson(jsonMessage);
          streamController.add(msg);
        } catch (e) {
          print('Error parsing JSON: $e');
        }
      },
      onDone: () {
        Future.delayed(const Duration(seconds: 5), () => _openStream(endpoint, fromJson, streamController));

      },
      onError: (error) {
        print('WebSocket error: $error');
        Future.delayed(const Duration(seconds: 5), () => _openStream(endpoint, fromJson, streamController));
      }
    );
  }

  // metodo per richiedere alla CO l'apertura di un canale full-duplex per ricevere gli update dell'emergenza
  Future<void> openEmergencyUpdateStream() async {
    await _openStream('/emergency', EmergencyDTO.fromJson, _streamEmergencyController);

  }

  // metodo per richiedere alla CO apertura canale full-duplex per ricevere update sul path da seguire
  // sia verso il paziente sia verso il PS
  Future<void> openPathUpdateStream() async {
    await _openStream('/path', PathDTO.fromJson, _streamPathController);

  }
}
