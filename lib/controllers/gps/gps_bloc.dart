import 'dart:async';

import 'package:geolocator/geolocator.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'gps_event.dart';
part 'gps_state.dart';

class GpsBloc extends Bloc<GpsEvent, GpsState> {
  GpsBloc() : super(GpsPause()) {
    on<GpsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}


void _getCurrentLocation() async {
  try {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  } catch (e) {
    print(e);
  }
}