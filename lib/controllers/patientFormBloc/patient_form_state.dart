part of 'patient_form_bloc.dart';

abstract class PatientFormState extends Equatable {
  const PatientFormState();

  @override
  List<Object?> get props => [];
}

class PatientFormInitial extends PatientFormState {}

class PatientFormLoading extends PatientFormState {}

class PatientFormSuccess extends PatientFormState {


}

class PatientFormFailure extends PatientFormState {
  final String error;

  const PatientFormFailure({required this.error});

  @override
  List<Object?> get props => [error];
}
