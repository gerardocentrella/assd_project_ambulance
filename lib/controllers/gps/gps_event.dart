part of 'gps_bloc.dart';

abstract class GpsEvent {
  const GpsEvent();
}

final class PatientReached extends GpsEvent {}

final class PSReached extends GpsEvent {}

final class InitEmergency extends GpsEvent {}

