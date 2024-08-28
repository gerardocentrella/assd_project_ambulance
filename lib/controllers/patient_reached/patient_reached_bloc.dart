// patient_reached_bloc.dart
import 'package:assd_project_ambulance/controllers/patient_controller.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'patient_reached_event.dart';
import 'patient_reached_state.dart';

class PatientReachedBloc extends Bloc<PatientReachedEvent, PatientReachedState> {
  final PatientReachedController _patientController;

  PatientReachedBloc(this._patientController) :
        super(PatientReachedInitial()) {
        on<SubmitPatientData>(_onSubmitPatientData);
  }


  void _onSubmitPatientData(SubmitPatientData event, Emitter<PatientReachedState> emit) async {

    try {
      //chiamata Restful
      await _patientController.sendNotification2(event.emerCode!, event.emergencyDescription, event.type, event.latitude, event.longitude,
      event.name, event.surname, event.city, event.address, event.age);
      print("Nel bloc Dopo la chiama REst ");
      //await Future.delayed(const Duration(seconds: 2)); // Simulazione di attesa
      emit(PatientReachedSuccess());

    } catch (e) {
      emit(PatientReachedFailure(error: e.toString()));
    }
  }
}
