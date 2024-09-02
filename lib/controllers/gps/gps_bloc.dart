import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../models/dto/PathDTO.dart';
import '../../models/repository/ambulanceId_repository.dart';
import '../message_controller.dart';

part 'gps_event.dart';
part 'gps_state.dart';

class GpsBloc extends Bloc<GpsEvent, GpsState> {
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
        super(GpsInitial(const {})) {
    on<InitEmergency>(_onInitEmergency);
    on<PatientReached>(_onPatientReached);
    on<PSReached>(_onPSReached);

    _initialize();
  }

  Future<void> _initialize() async {
    try {
      await _ambulanceIdRepository.saveAmbulanceId("AMB00001");
      ambulanceId = await _ambulanceIdRepository.getAmbulanceId();
      if (ambulanceId == null) {
        emit(const GpsError('Ambulance ID not found', const {}));
        return;
      }

      await _initializeStreams();
    } catch (e) {
      emit(GpsError(e.toString(), const {}));
    }
  }

  String get pathURL {
    if (ambulanceId != null) {
      return 'ws://172.31.4.63:30202/pathNotifier/websocket/ambulances/$ambulanceId/path';
    }
    throw Exception('Ambulance ID is not initialized');
  }

  Future<void> _initializeStreams() async {
    try {
      _messageController.openPathStream(pathURL);
      _messageController.pathStream.listen((path) {
        if (path.path.isNotEmpty) {
          markers = _createMarkersFromPositions(path.path.cast<Position>());
          add(InitEmergency());
        } else {
          emit(const GpsError('Path data is empty', const {}));
        }
      });
    } catch (e) {
      emit(GpsError(e.toString(), const {}));
    }
  }

  Future<void> _onInitEmergency(
      InitEmergency event,
      Emitter<GpsState> emit,
      ) async {
    emit(GpsOnPatient(markers));
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
    // Placeholder for real position data retrieval
    return [
    ];
  }

  Set<Marker> _createMarkersFromPositions(List<Position> positions) {
    return positions.asMap().entries.map((entry) {
      int index = entry.key;
      Position position = entry.value;
      return Marker(
        position: LatLng(position.latitude, position.longitude),
        markerId: MarkerId(index.toString()),
        infoWindow: InfoWindow(title: 'Point ${index + 1}'),
      );
    }).toSet();
  }
}

