part of 'gps_bloc.dart';

abstract class GpsEvent extends Equatable {
  const GpsEvent();
}

final class PatientReached extends GpsEvent {
  @override

  List<Object?> get props => [];
}

final class PSReached extends GpsEvent {
  @override

  List<Object?> get props => [];
}

final class InitEmergency extends GpsEvent {
  @override

  List<Object?> get props => [];
}