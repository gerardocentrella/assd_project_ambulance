part of 'gps_bloc.dart';

abstract class GpsState extends Equatable {
  const GpsState();
}

class GpsOnPatient extends GpsState {
  late final Emergency emergency;



  @override
  List<Object> get props => [];
}

class GpsOnPS extends GpsState {
  @override
  List<Object> get props => [];
}

class GpsOnPause extends GpsState {
  @override
  List<Object> get props => [];
}