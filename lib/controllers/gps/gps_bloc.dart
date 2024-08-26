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
    // Retrieve list of positions from repository or some other source
    List<Position> positions = await _retrievePositions();
    Set<Marker> _markers = _createMarkersFromPositions(positions);

    emit(GpsOnPatient(_markers));
  }

  Future<void> _onPatientReached(
      PatientReached event,
      Emitter<GpsState> emit,
      ) async {
    // Retrieve updated list of positions when patient is reached
    List<Position> positions = await _retrievePositions();
    Set<Marker> _markers = _createMarkersFromPositions(positions);

    emit(GpsOnPS(_markers));
  }

  void _onPSReached(
      PSReached event,
      Emitter<GpsState> emit,
      ) {
    // Clear markers and pause GPS updates
    emit(GpsOnPause(const {}));
  }

  // Example method to simulate retrieving positions from the repository
  Future<List<Position>> _retrievePositions() async {
    // Replace this with your actual retrieval logic
    return [
      Position(
        latitude: 40.851775, // Naples
        longitude: 14.268124,
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
        longitude: 14.505223,
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
        latitude: 40.630387, // Amalfi
        longitude: 14.602920,
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
