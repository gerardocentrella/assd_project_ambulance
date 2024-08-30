// events/path_event.dart
import '../../models/dto/PathDTO.dart';

abstract class PathEvent {}

class PathReceived extends PathEvent {
  final PathDTO path;

  PathReceived(this.path);
}

class PathEnded extends PathEvent {}