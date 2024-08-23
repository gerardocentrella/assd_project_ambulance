
import 'dart:async';
import 'dart:convert';
import 'dart:math';

import '../entities/Emergency.dart';

class EmergencyRepository {
  final String baseUrl;

  EmergencyRepository(this.baseUrl);

  Future<Map<String, dynamic>?> getEmergencyInfo(String emergencyID) async {
    // Stub: Return fake emergency info
    return {
      'emergencyUpdateUrl': 'wss://centraleOperativa.it/websocket/emergencies/ABCD1234/'
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

  void openAmbulanceWebSocket(String url, Function(Map<String, dynamic>) onMessage) {
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


  void openEmergencyWebSocket(String url, Function(Map<String, dynamic>) onMessage) {
    //Simulate receiving messages from the WebSocket at intervals
    Timer.periodic(Duration(seconds: 5), (timer) {
      final List<String> emergencyStatuses = ['ER_SELECTED', 'FULFILLED', 'AMBULANCE_SELECTED', 'SUBMITTED'];
      final randomStatus = emergencyStatuses[Random().nextInt(emergencyStatuses.length)];
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
          "position": {
            "latitude": 41.131546,
            "longitude": 14.777791
          }
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
