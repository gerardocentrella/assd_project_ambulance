import 'dart:async';
import 'package:assd_project_ambulance/controllers/patient_controller.dart';
import 'package:assd_project_ambulance/controllers/services/patient_reached_service.dart';
import 'package:assd_project_ambulance/models/repository/emergencyId_repository.dart';
import 'package:assd_project_ambulance/utils/http_result.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/dto/PathDTO.dart';
import '../../models/entities/Emergency.dart';
import '../../models/entities/Position.dart';

// Eventi per il PatientFormBloc
part 'patient_form_event.dart';

// Stati per il PatientFormBloc
part 'patient_form_state.dart';

class PatientFormBloc extends Bloc<PatientFormEvent, PatientFormState> {
  final PatientReachedController _controller;
  final EmergencyIdRepository _emergencyIdRepository;
  String? emergencyId;

  // Costruttore con stato iniziale
  PatientFormBloc(this._controller, this._emergencyIdRepository)
      : super(PatientFormInitial()) {
    on<PatientFormEventSubmit>(_onSubmit);
    on<PatientFormEventSuccess>(_onSuccess);
    on<PatientFormEventFailure>(_onFailure);
  }

  PathDTO? pdto = null;

  // Logica per l'evento di submit
  Future<void> _onSubmit(
    PatientFormEventSubmit event,
    Emitter<PatientFormState> emit,
  ) async {
    emit(PatientFormLoading());

// Recupera l'emergencyId dal repository
    String? emergencyId = await _emergencyIdRepository.getEmergencyId();
    if (emergencyId == null) {
      emit(PatientFormFailure(error: "Emergency ID not found."));
      return;
    }

// Imposta l'emergencyId nel controller
    _controller.setEmergencyId(emergencyId);

    try {
      final HttpResult<PathDTO> result;
      // Qui dovresti chiamare un servizio che invia i dati a un backend o lo salva localmente
      result = await _controller.sendNotification2(
          event.emerCode,
          event.emergencyDescription,
          event.type,
          event.latitude,
          event.longitude,
          event.name,
          event.surname,
          event.city,
          event.address,
          event.age);

      if (result.data != null && result.httpStatusCode == 200) {
        pdto = result.data;
        // successo
      } else {
        // fallimento
      }
    } catch (error) {
      emit(PatientFormFailure(error: error.toString()));
    }
  }

  // Logica per l'evento di successo
  Future<void> _onSuccess(
    PatientFormEventSuccess event,
    Emitter<PatientFormState> emit,
  ) async {
    emit(PatientFormSuccess());
  }

  // Logica per l'evento di fallimento
  Future<void> _onFailure(
    PatientFormEventFailure event,
    Emitter<PatientFormState> emit,
  ) async {
    emit(PatientFormFailure(error: event.error));
  }

  List<Position>? getPath() {
    if (pdto == null) {
      return null;
    } else {
      return pdto!.path;
    }
  }
}
