
part of 'gps_bloc.dart';

abstract class GpsState extends Equatable {
  final Set<Marker> markers;

  const GpsState(this.markers);

  @override
  List<Object> get props => [markers];
}

class GpsInitial extends GpsState {
  GpsInitial(Set<Marker> markers) : super(markers);

  @override
  List<Object> get props => [markers];
}

class GpsOnPatient extends GpsState {
  GpsOnPatient(Set<Marker> markers) : super(markers);

  @override
  List<Object> get props => [markers];
}

class GpsOnPS extends GpsState {
  GpsOnPS(Set<Marker> markers) : super(markers);

  @override
  List<Object> get props => [markers];
}

class GpsOnPause extends GpsState {
  GpsOnPause(Set<Marker> markers) : super(markers);

  @override
  List<Object> get props => [markers];
}

class GpsError extends GpsState {
  final String message;

  const GpsError(this.message, Set<Marker> markers) : super(markers);

  @override
  List<Object> get props => [message, markers];
}
