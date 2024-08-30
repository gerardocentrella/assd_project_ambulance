part of 'gps_bloc.dart';

abstract class GpsState extends Equatable {

  final Set<Marker> markers;
   const GpsState(this.markers);
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

// parte aggiunta inizializzazione
class GpsInitial extends GpsState {
  const GpsInitial() : super(const {}); // Passa un insieme vuoto di marker

  @override
  List<Object> get props => [];
}