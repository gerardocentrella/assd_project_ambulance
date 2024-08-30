// states/path_state.dart
import 'package:equatable/equatable.dart';
import '../../models/dto/PathDTO.dart';

abstract class PathState extends Equatable {
  const PathState();

  @override
  List<Object> get props => [];
}

// Stato di inizializzazione
class PathInitial extends PathState {}

// Stato di ascolto
class PathListening extends PathState {}

// Stato di elaborazione del percorso
class PathProcessing extends PathState {
  final PathDTO path;

  const PathProcessing(this.path);

  @override
  List<Object> get props => [path];
}

// Stato di errore
class PathError extends PathState {
  final String message;

  const PathError(this.message);

  @override
  List<Object> get props => [message];
}