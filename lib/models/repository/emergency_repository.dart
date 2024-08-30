import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:assd_project_ambulance/controllers/message_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../controllers/emergency/emegency_event.dart';
import '../../controllers/emergency/emergency_bloc.dart';
import '../dto/EmergencyDTO.dart';
import '../entities/Emergency.dart';
import '../entities/Position.dart';

class EmergencyRepository {
  final String baseUrl;
 // final MessageController _controller;
  // final EmergencyBloc emergencyBloc;

  EmergencyRepository(this.baseUrl) {
    print("CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC");
    // Inizializza i canali quando si crea il repository
    //_openEmergencyStream();

    //_simulateEmergencyReceiving();
  }
/*
  void _openEmergencyStream() {
    print("OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO");
    String ambulanceId = "AMB00001";
    String emergencyURL =
        'ws://172.31.4.63:31656/emergencyNotifier/websocket/ambulances/$ambulanceId/emergencies';

    _controller.openEmergencyStream(emergencyURL);

    _controller.emergencyStream.listen((EmergencyDTO emergency) {
      // Passa l'emergenza al bloc
      emergencyBloc.add(EmergencyReceived(emergency));
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
      emergencyBloc.add(EmergencyReceived(emergency));
    });
  }


 */
  Future<Map<String, dynamic>?> getEmergencyInfo(String emergencyID) async {
    // Stub: Return fake emergency info
    return {
      'emergencyUpdateUrl':
          'wss://centraleOperativa.it/websocket/emergencies/ABCD1234/'
    };

    // Original implementation
    // final response = await http.get(
    //   Uri.parse('$baseUrl/emergencies/$emergencyID'),
    //   headers: {'Content-Type': 'application/json'},
    // );

    // if (response.statusCode == 200) {
    //   return jsonDecode(response.body);
    // } else {
    //   return null;
    // }
  }

  void openAmbulanceWebSocket(
      String url, Function(Map<String, dynamic>) onMessage) {
    // Stub: Simulate receiving messages from the WebSocket
    Timer.periodic(Duration(seconds: 5), (timer) {
      onMessage({
        // coordinate di salerno
        'latitude': 40.6806,
        'longitude': 14.7597,
      });
    });

    //    const myUrl = 'ws://localhost:8080/websocket/ambulances/5678EFGH/position';
    //   WebSocketChannel channel;

    // //  original implementation commented out for the stub
    //   void connect() {
    //     channel = WebSocketChannel.connect(Uri.parse(myUrl));
    //     channel.stream.listen(
    //       (message) {
    //         try {
    //           final data = jsonDecode(message);
    //           onMessage(data);
    //         } catch (e) {
    //           print('Error parsing JSON: $e');
    //         }
    //       },
    //       onDone: () {
    //         Future.delayed(Duration(seconds: 5), connect);
    //       },
    //       onError: (error) {
    //         print('WebSocket error: $error');
    //         Future.delayed(Duration(seconds: 5), connect);
    //       },
    //     );
    //   }

    //   connect();
  }

  void openEmergencyWebSocket(
      String url, Function(Map<String, dynamic>) onMessage) {
    //Simulate receiving messages from the WebSocket at intervals
    Timer.periodic(Duration(seconds: 5), (timer) {
      final List<String> emergencyStatuses = [
        'ER_SELECTED',
        'FULFILLED',
        'AMBULANCE_SELECTED',
        'SUBMITTED'
      ];
      final randomStatus =
          emergencyStatuses[Random().nextInt(emergencyStatuses.length)];
      //Generate a simulated emergency message
      //realmente il messaggio dovrebbe essere una cosa del genere:
      final message = jsonEncode({
        "id": "ABCD1234",
        "emergencyCode": "ROSSO",
        "emergencyStatus": randomStatus,
        // ER_SELECTED FULFILLED AMBULANCE_SELECTED SUBMITTED
        "emergencyDescription": "Dolore Toracico",
        "emergencyType": "C02",
        "ambulanceId": "5678EFGH",
        "emergencyRoom": {
          "id": "ABCD1234",
          "name": "Ospedale Fatebenefratelli",
          "city": "Benevento",
          "address": "Via Roma 1",
          "position": {"latitude": 41.131546, "longitude": 14.777791}
        }
      });

      //Call the onMessage function with the parsed JSON data
      onMessage(jsonDecode(message));
    });

    // String myUrl = 'ws://localhost:8080/websocket/emergencies/ABCD1234';
    // // Original implementation commented out for the stub
    // WebSocketChannel channel;
    // void connect() {
    //   channel = WebSocketChannel.connect(Uri.parse(myUrl));
    //   channel.stream.listen(
    //     (message) {
    //       try {
    //         final data = jsonDecode(message);
    //         onMessage(data);
    //       } catch (e) {
    //         print('Error parsing JSON: $e');
    //       }
    //     },
    //     onDone: () {
    //       Future.delayed(Duration(seconds: 5), connect);
    //     },
    //     onError: (error) {
    //       print('WebSocket error: $error');
    //       Future.delayed(Duration(seconds: 5), connect);
    //     },
    //   );
    // }

    // connect();
  }
}
