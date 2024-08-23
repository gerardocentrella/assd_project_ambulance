
import 'dart:async';

import 'package:geolocator/geolocator.dart';

class PositionRepository {

  Stream<Position> get status async* {
    yield* Geolocator.getPositionStream();
  }

}