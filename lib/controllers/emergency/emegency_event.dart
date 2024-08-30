// events/emergency_event.dart
import '../../models/dto/EmergencyDTO.dart';

abstract class EmergencyEvent {}

class EmergencyReceived extends EmergencyEvent {
  final EmergencyDTO emergency;

  EmergencyReceived(this.emergency);
}

class EmergencyEnded extends EmergencyEvent {}

// evento per gestire chiusura  canale alla chiusura dell'app
//class EmergencyDispose extends EmergencyEvent {}