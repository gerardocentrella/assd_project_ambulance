import 'dart:async';
import 'package:assd_project_ambulance/models/repository/emergency_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../models/repository/position_repository.dart';

part 'gps_event.dart';
part 'gps_state.dart';
class GpsBloc extends Bloc<GpsEvent, GpsState> {
  GpsBloc({
    required PositionRepository positionRepository,
    required EmergencyRepository emergencyRepository,
  })  : _positionRepository = positionRepository,
        _emergencyRepository = emergencyRepository,
        super(GpsOnPause(const {})) {
    on<InitEmergency>(_onInitEmergency);
    on<PatientReached>(_onPatientReached);
    on<PSReached>(_onPSReached);
  }

  final EmergencyRepository _emergencyRepository;
  final PositionRepository _positionRepository;

  Future<void> _onInitEmergency(
      InitEmergency event,
      Emitter<GpsState> emit,
      ) async {
    List<Position> positions = await _retrievePositions();
    Set<Marker> _markers = _createMarkersFromPositions(positions);

    emit(GpsOnPatient(_markers));
  }

  Future<void> _onPatientReached(
      PatientReached event,
      Emitter<GpsState> emit,
      ) async {
    List<Position> positions = await _retrievePositions();
    Set<Marker> _markers = _createMarkersFromPositions(positions);

    emit(GpsOnPS(_markers));
  }

  void _onPSReached(
      PSReached event,
      Emitter<GpsState> emit,
      ) {
    emit(GpsOnPause(const {}));
  }

  Future<List<Position>> _retrievePositions() async {
    return [
      Position(
        latitude: 40.851775, // Naples
        longitude: 13.268124,
        timestamp: DateTime.now(),
        accuracy: 10.0,
        altitude: 0.0,
        heading: 0.0,
        speed: 0.0,
        speedAccuracy: 0.0,
        altitudeAccuracy: 0.0,
        headingAccuracy: 0.0,
      ),
      Position(
        latitude: 40.682441, // Pompeii
        longitude: 16.505223,
        timestamp: DateTime.now(),
        accuracy: 10.0,
        altitude: 0.0,
        heading: 0.0,
        speed: 0.0,
        speedAccuracy: 0.0,
        altitudeAccuracy: 0.0,
        headingAccuracy: 0.0,
      ),
      Position(
        latitude: 0.630387, // Amalfi
        longitude: 0.602920,
        timestamp: DateTime.now(),
        accuracy: 10.0,
        altitude: 0.0,
        heading: 0.0,
        speed: 0.0,
        speedAccuracy: 0.0,
        altitudeAccuracy: 0.0,
        headingAccuracy: 0.0,
      ),
    ];
  }

  Set<Marker> _createMarkersFromPositions(List<Position> positions) {
    Set<Marker> markers = {};
    for (var i = 0; i < positions.length; i++) {
      markers.add(
        Marker(
          position: LatLng(positions[i].latitude, positions[i].longitude),
          markerId: MarkerId(i.toString()),
        ),
      );
    }
    return markers;
  }
}
