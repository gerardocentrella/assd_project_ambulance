// states/emergency_state.dart
import 'package:equatable/equatable.dart';

import '../../models/dto/EmergencyDTO.dart';

abstract class EmergencyState extends Equatable {
  const EmergencyState();

  @override
  List<Object> get props => [];
}

class EmergencyInitial extends EmergencyState {}

class EmergencyLoading extends EmergencyState {}

class EmergencyLoaded extends EmergencyState {
  final EmergencyDTO emergency;

  const EmergencyLoaded(this.emergency);

  @override
  List<Object> get props => [emergency];
}

class EmergencyError extends EmergencyState {
  final String message;

  const EmergencyError(this.message);

  @override
  List<Object> get props => [message];
}
