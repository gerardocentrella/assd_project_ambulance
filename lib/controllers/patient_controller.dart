import 'package:assd_project_ambulance/utils/http_result.dart';
import 'package:assd_project_ambulance/controllers/services/patient_reached_service.dart';
import 'package:assd_project_ambulance/models/dto/PatientReachedNotificationDTO.dart';
import 'package:assd_project_ambulance/models/entities/Position.dart';
import '../models/dto/PathDTO.dart';
import '../models/entities/Emergency.dart';
import '../models/entities/Patient.dart';

/*
Classe intermedia che adopera un service specifico per compiere una richiesta all'API remota per comunicare che l'ambulanza ha
raggiunto il paziente. Ha lo scopo di wrappare codice specifico da richiamare in un bloc specifico.
 */

class PatientReachedController {
  // Iniettiamo il servizio tramite il costruttore: dependency injection
  final PatientReachedService _service;

  PatientReachedController(this._service);



  String emergencyId = '';
  late String _error;

  // Metodo per impostare l'emergencyId
  void setEmergencyId(String id) {
    emergencyId = id;
  }

  Future<HttpResult<String>> sendNotification2(
      EmergencyCode emrcode,
      String emrdesc,
      EmergencyType emrtype,
      double latitude,
      double longitude,
      String name,
      String surname,
      String city,
      String address,
      int age) async {
    print("Sono in PatientReachedController");
    Patient pat = Patient(
        name: name, surname: surname, city: city, address: address, age: age);
    Position pos = Position(latitude: latitude, longitude: longitude);
    PatientReachedNotificationDTO pdto =
        PatientReachedNotificationDTO(emrcode, emrdesc, emrtype, pos, pat);

    try {
      final result =
          await _service.sendPatientReachedNotification2(pdto, emergencyId);

      return result; // Restituire il risultato
    } catch (e) {
      _error = e.toString(); // Gestire il possibile errore
      throw _error; // rimanere con la gestione dell'errore
    }
  }
}
