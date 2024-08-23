import 'package:assd_project_ambulance/controllers/services/HttpResult.dart';
import 'package:assd_project_ambulance/controllers/services/patient_reached_service.dart';
import 'package:assd_project_ambulance/models/dto/PatientReachedNotificationDTO.dart';
import 'package:assd_project_ambulance/models/entities/Position.dart';
import '../models/dto/PathDTO.dart';
import '../models/entities/Emergency.dart';
import '../models/entities/Patient.dart';

class PatientController {
  // vediamo sono soltanto due approcci semplici
  // in seguito vedere approcci più complessi tra cui uno impiegante ControllerMVC e l'altro che prevede il concetto di Provider!

  PatientController();

  // primo approccio di controllo
  Future<void> sendNotification(
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
    Patient pat = Patient(
        name: name, surname: surname, city: city, address: address, age: age);
    Position pos = Position(latitude: latitude, longitude: longitude);
    PatientReachedNotificationDTO pdto =
        PatientReachedNotificationDTO(emrcode, emrdesc, emrtype, pos, pat);

    /*chiamare il servizio restful nella cartella services e passare il dto*/
    PathDTO path =
        PatientReachedService.sendPatientReachedNotification(pdto) as PathDTO;
    List<Position> positions = path.path;
  }

  //--------------------------------------------secondo approccio------------------------------------------------------

  // creazione oggetto qui oppure ricorso alla dependency injection
  final PatientReachedService _service = PatientReachedService();
  String emergencyId = '';

  Future<HttpResult<PathDTO>> sendNotification2(
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
    Patient pat = Patient(
        name: name, surname: surname, city: city, address: address, age: age);
    Position pos = Position(latitude: latitude, longitude: longitude);
    PatientReachedNotificationDTO pdto =
        PatientReachedNotificationDTO(emrcode, emrdesc, emrtype, pos, pat);

    return await _service.sendPatientReachedNotification2(pdto, emergencyId);
  }
}
