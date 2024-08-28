import 'package:assd_project_ambulance/controllers/services/emergency_room_reached_service.dart';
import '../utils/http_result.dart';

class EmergencyRoomReachedController {
  final EmergencyRoomReachedService _service;

  // iniezione servizio nel costruttore
  EmergencyRoomReachedController(this._service);

  String emergencyId = '';
  late String _error;

  Future<HttpResult> sendEmergencyRoomReachedNotification(
      String emergencyId) async {
    try {
      final result =
          await _service.sendEmergencyRoomReachedNotification(emergencyId);
      return result; // Restituire il risultato
    } catch (e) {
      _error = e.toString(); // Gestire il possibile errore
      throw _error; // rimanere con la gestione dell'errore
    }
  }
}
