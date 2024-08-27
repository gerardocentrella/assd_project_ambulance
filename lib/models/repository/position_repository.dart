import 'dart:async';
import 'package:geolocator/geolocator.dart';

class PositionRepository {
  Stream<Position> get positionStream async* {
    // Assicurati che i permessi siano concessi e che i servizi di localizzazione siano attivi
    bool isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!isLocationServiceEnabled) {
      throw Exception('Location services are disabled.');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception('Location permissions are permanently denied.');
    }

    // Emissione continua della posizione corrente
    await for (final position in Geolocator.getPositionStream()) {
      yield position;
    }
  }
}
