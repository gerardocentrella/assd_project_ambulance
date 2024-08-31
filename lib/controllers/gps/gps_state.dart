part of 'gps_bloc.dart';

abstract class GpsState extends Equatable {

  final Set<Marker> markers;
   const GpsState(this.markers);
}

// aggiunta di uno stato di inizializzazione
class GpsInitial extends GpsState {
  GpsInitial(super.markers);

  @override
  List<Object> get props => [];

}

class GpsOnPatient extends GpsState {
  @override
  List<Object> get props => [];

  GpsOnPatient(super.markers);
}

class GpsOnPS extends GpsState {
  @override
  List<Object> get props => [];

  GpsOnPS(super.markers);
}

class GpsOnPause extends GpsState {
  GpsOnPause(super.markers);

  @override
  List<Object> get props => [];
}

// nuovo stato aggiunto per errori
// Stato di errore
class GpsError extends GpsState {
  final String message;

  const GpsError(this.message, super.markers);

  @override
  List<Object> get props => [message];

}