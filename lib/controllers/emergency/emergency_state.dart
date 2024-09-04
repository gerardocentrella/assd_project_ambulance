// states/emergency_state.dart
import 'package:equatable/equatable.dart';
import '../../models/dto/EmergencyDTO.dart';

abstract class EmergencyState extends Equatable {
  const EmergencyState();

  @override
  List<Object> get props => [];
}

// Stato di inizializzazione
class EmergencyInitial extends EmergencyState {}

// Stato di ascolto
class EmergencyListening extends EmergencyState {}

// Stato di elaborazione
class EmergencyProcessing extends EmergencyState {
  final EmergencyDTO emergency;

  const EmergencyProcessing(this.emergency);

  @override
  List<Object> get props => [emergency];
}

// Stato di errore
class EmergencyError extends EmergencyState {
  final String message;

  const EmergencyError(this.message);

  @override
  List<Object> get props => [message];
}

