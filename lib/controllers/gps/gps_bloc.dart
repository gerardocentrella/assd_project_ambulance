import 'dart:async';

import 'package:assd_project_ambulance/models/entities/Emergency.dart';
import 'package:assd_project_ambulance/models/repository/emergency_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/repository/position_repository.dart';

part 'gps_event.dart';
part 'gps_state.dart';

class GpsBloc extends Bloc<GpsEvent, GpsState> {
  GpsBloc({required PositionRepository positionRepository, required EmergencyRepository emergencyRepository})
      : _positionRepository = positionRepository,
        _emergencyRepository = emergencyRepository,
        super(GpsOnPause()) {
    on<InitEmergency>(_onInitEmergency);
    on<PatientReached>(_onPatientReached);
    on<PSReached>(_onPSReached);
  }

  final EmergencyRepository _emergencyRepository;
  final PositionRepository _positionRepository;

  void _onInitEmergency(GpsEvent event,
      Emitter<GpsState> emit,) {


  }

  void _onPatientReached(GpsEvent event,
      Emitter<GpsState> emit,) {


  }

  void _onPSReached(GpsEvent event,
      Emitter<GpsState> emit,) {

  }
}


