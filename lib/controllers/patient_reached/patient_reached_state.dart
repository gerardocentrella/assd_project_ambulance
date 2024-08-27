// patient_reached_state.dart
import 'package:equatable/equatable.dart';


abstract class PatientReachedState extends Equatable {
  const PatientReachedState();

  @override
  List<Object?> get props => [];
}

//Quello che mostra la view all'inizio
class PatientReachedInitial extends PatientReachedState {}

class PatientReachedLoading extends PatientReachedState {}

class PatientReachedSuccess extends PatientReachedState {

  PatientReachedSuccess(){
    print("\n\n\n sono in success\n\n");
  }

}

class PatientReachedFailure extends PatientReachedState {
  final String error;

  const PatientReachedFailure({required this.error});

  @override
  List<Object?> get props => [error];
}
