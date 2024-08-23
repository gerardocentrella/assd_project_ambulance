import 'dart:async';

import 'package:assd_project_ambulance/models/dto/EmergencyDTO.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketManager {
  final url = '';
  late WebSocketChannel channel;
  final StreamController<EmergencyDTO> _streamEmergencyController =
      StreamController.broadcast();

  WebSocketManager();

  //WebSocketManager(this.url);
  void connect() {
    channel = WebSocketChannel.connect(Uri.parse(url));

  }
}
