import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../models/dto/PathDTO.dart';
import '../../models/repository/ambulanceId_repository.dart';
import '../../models/repository/position_repository.dart';
import '../message_controller.dart';

part 'gps_event.dart';

part 'gps_state.dart';

class GpsBloc extends Bloc<GpsEvent, GpsState> {
  // aggiunta dichiarazioni controller, repository
  final MessageController _messageController;
  final AmbulanceIdRepository _ambulanceIdRepository;
  String? ambulanceId;
  PathDTO? currentPath;
  late Set<Marker> markers;

  GpsBloc({
    required MessageController messageController,
    required AmbulanceIdRepository ambulanceIdRepository,
  })  : _messageController = messageController,
        _ambulanceIdRepository = ambulanceIdRepository,
        // modifica: partiamo da GpsInitial
        super(GpsInitial(const {})) {
    on<InitEmergency>(_onInitEmergency);
    on<PatientReached>(_onPatientReached);
    on<PSReached>(_onPSReached);

    // inizializzazione stream e ascolto
    _initialize();
  }

  // aggiunta di inizializzazione
  Future<void> _initialize() async {
    try {
      // Recupera l'ID dell'ambulanza
      await _ambulanceIdRepository.saveAmbulanceId("AMB00001");
      ambulanceId = await _ambulanceIdRepository.getAmbulanceId();
      if (ambulanceId == null) {
        emit(const GpsError('Ambulance ID not found', const {}));
        return;
      }

      // Procedi con l'inizializzazione ora che l'ID è stato recuperato
      _initializeStreams();
      // simulazione ricezione path
      //_simulatePathReceiving();
    } catch (e) {
      emit(GpsError(e.toString(), const {}));
    }
  }

  // creazione url per path
  String get pathURL {
    if (ambulanceId != null) {
      return 'ws://172.31.4.63:30202/pathNotifier/websocket/ambulances/$ambulanceId/path';
    }
    throw Exception('Ambulance ID is not initialized');
  }

  // apertura canale ricezione path e messa in ascolto
  void _initializeStreams() {
    // Apro stream per percorsi
    // Per testare con emulatore android usare path --> ws://10.0.2.2:8765/pathNotifier
    _messageController.openPathStream(pathURL);

    // Ascolta lo stream dei percorsi
    _messageController.pathStream.listen((path) {
      markers = _createMarkersFromPositions(path.path.cast<Position>());
      emit(GpsOnPatient(markers));
    });
  }


  //------------------------------- parte originale di francesco ----------------------------------------------------------------
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
        latitude: 40.851775,
        // Naples
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
        latitude: 40.682441,
        // Pompeii
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
        latitude: 0.630387,
        // Amalfi
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
