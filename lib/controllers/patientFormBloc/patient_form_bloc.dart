import 'dart:async';
import 'package:assd_project_ambulance/controllers/patient_controller.dart';
import 'package:assd_project_ambulance/controllers/services/patient_reached_service.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/entities/Emergency.dart';
import '../../utils/enum_menu_code.dart';

// Eventi per il PatientFormBloc
part 'patient_form_event.dart';

// Stati per il PatientFormBloc
part 'patient_form_state.dart';

class PatientFormBloc extends Bloc<PatientFormEvent, PatientFormState> {
  // Costruttore con stato iniziale
  PatientFormBloc() : super(PatientFormInitial()) {
    on<PatientFormEventSubmit>(_onSubmit);
    on<PatientFormEventSuccess>(_onSuccess);
    on<PatientFormEventFailure>(_onFailure);
  }

  final PatientReachedController _controller =
      PatientReachedController(PatientReachedService());

  // Logica per l'evento di submit
  Future<void> _onSubmit(
    PatientFormEventSubmit event,
    Emitter<PatientFormState> emit,
  ) async {
    emit(PatientFormLoading());
    try {
      // Qui dovresti chiamare un servizio che invia i dati a un backend o lo salva localmente
      await _controller.sendNotification2(
          event.emerCode! as EmergencyCode,
          event.emergencyDescription,
          event.type,
          event.latitude,
          event.longitude,
          event.name,
          event.surname,
          event.city,
          event.address,
          event.age);
      print("Nel bloc nuovo Dopo la chiama REst ");
      await Future.delayed(
          Duration(seconds: 2)); // Simulazione di una richiesta di rete
      emit(PatientFormSuccess());
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
}
