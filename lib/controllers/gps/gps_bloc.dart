import 'dart:async';

import 'package:assd_project_ambulance/models/entities/Emergency.dart';
import 'package:assd_project_ambulance/models/repository/emergency_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../models/repository/position_repository.dart';

part 'gps_event.dart';
part 'gps_state.dart';

class GpsBloc extends Bloc<GpsEvent, GpsState> {
  GpsBloc({required PositionRepository positionRepository, required EmergencyRepository emergencyRepository})
      : _positionRepository = positionRepository,
        _emergencyRepository = emergencyRepository,
        super(GpsOnPause({})) {
    on<InitEmergency>(_onInitEmergency);
    on<PatientReached>(_onPatientReached);
    on<PSReached>(_onPSReached);
  }

  final EmergencyRepository _emergencyRepository;
  final PositionRepository _positionRepository;

  void _onInitEmergency(InitEmergency event,
      Emitter<GpsState> emit,) {
    List<Position> positions = [];
    Set<Marker> _markers = {};
    
    // retrive list of position
    int i = 0;
    for (var pos in positions) {
      _markers.add(Marker(position: LatLng(pos.latitude, pos.longitude), markerId: MarkerId(i.toString())));
      i++;
    }
    emit.call(GpsOnPatient(_markers));
  }

  void _onPatientReached(PatientReached event,
      Emitter<GpsState> emit,) {
    List<Position> positions = [];
    Set<Marker> _markers = {};

    // retrive list of position
    int i = 0;
    for (var pos in positions) {
      _markers.add(Marker(position: LatLng(pos.latitude, pos.longitude), markerId: MarkerId(i.toString())));
      i++;
    }
    emit.call(GpsOnPS(_markers));
  }

  void _onPSReached(PSReached event,
      Emitter<GpsState> emit,) {
    emit.call(GpsOnPause(const {}));
    // reset

  }
}


