part of 'gps_bloc.dart';

abstract class GpsEvent extends Equatable {
  const GpsEvent();
}

final class PatientReached extends GpsEvent {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

final class PSReached extends GpsEvent {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

final class InitEmergency extends GpsEvent {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}