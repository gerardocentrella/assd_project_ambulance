
import 'dart:async';

import 'package:geolocator/geolocator.dart';

class PositionRepository {

  Stream<Position> get status async* {
    LocationPermission permission;
    permission = await Geolocator.requestPermission();

    if (permission.index>=2){
      yield* Geolocator.getPositionStream();
    } else {
      yield* const Stream.empty();
    }

  }

}