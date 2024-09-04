// events/emergency_event.dart
import '../../models/dto/EmergencyDTO.dart';
import '../../models/dto/PathDTO.dart';

abstract class EmergencyEvent {}

class EmergencyReceived extends EmergencyEvent {
  final EmergencyDTO emergency;

  EmergencyReceived(this.emergency);
}

class EmergencyEnded extends EmergencyEvent {}

class EmergencyInitialization extends EmergencyEvent {}
