import 'package:assd_project_ambulance/models/dto/PatientReachedNotificationDTO.dart';
import 'package:assd_project_ambulance/models/entities/Position.dart';
import '../models/entities/Emergency.dart';
import '../models/entities/Patient.dart';


class PatientController{

  PatientController();

  void sendNotification(EmergencyCode emrcode, String emrdesc, EmergencyType emrtype,
      double latitude, double longitude, String name, String surname, String city,
      String address, int age) async{

    Patient pat = new Patient(name: name,surname:  surname,city:  city, address: address, age: age);
    Position pos = new Position(latitude: latitude, longitude: longitude);
    PatientReachedNotificationDTO pdto = new PatientReachedNotificationDTO(emrcode, emrdesc, emrtype, pos, pat);

    /*chiamare il servizio restful nella cartella services e passare il dto*/



  }
}