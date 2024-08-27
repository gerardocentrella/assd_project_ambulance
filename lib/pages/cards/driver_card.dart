import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import '../../controllers/gps/gps_bloc.dart';
import '../../models/repository/position_repository.dart';

class DriverCard extends StatefulWidget {
  const DriverCard({Key? key}) : super(key: key);

  @override
  _DriverCardState createState() => _DriverCardState();
}

class _DriverCardState extends State<DriverCard> {
  Set<Marker> _markers = {};
  Set<Polyline> _polylines = {};
  GoogleMapController? _mapController;
  LatLng? _currentPosition;
  Timer? _timer;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BlocListener<GpsBloc, GpsState>(
        listener: (context, state) async {
          if (state is GpsOnPatient || state is GpsOnPS) {
            _markers = state.markers;
            _polylines = _createPolylineFromMarkers(_markers);
            setState(() {});

            if (_markers.isNotEmpty) {
              _startNavigation(_markers);
            }
          } else if (state is GpsOnPause) {
            _stopNavigation();
            setState(() {
              _markers.clear();
              _polylines.clear();
            });
          }
        },
        child: Card(
          color: Colors.indigo,
          shadowColor: Colors.lightGreen,
          elevation: 5,
          margin: const EdgeInsets.all(16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: FutureBuilder<Position?>(
              future: context.read<PositionRepository>().status,
              builder: (BuildContext context, AsyncSnapshot<Position?> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return const Text("Errore nel recupero della posizione");
                } else if (snapshot.hasData && snapshot.data != null) {
                  Position position = snapshot.data!;
                  _currentPosition = LatLng(position.latitude, position.longitude);

                  _markers.add(
                    Marker(
                      markerId: const MarkerId('current_position'),
                      position: _currentPosition!,
                      infoWindow: const InfoWindow(title: 'Ambulanza'),
                    ),
                  );

                  _polylines = _createPolylineFromMarkers(_markers);

                  return GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: _currentPosition!,
                      zoom: 14.0,
                    ),
                    markers: _markers,
                    polylines: _polylines,
                    onMapCreated: (controller) {
                      _mapController = controller;
                    },
                  );
                } else {
                  return const Text("Non hai i permessi");
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  Set<Polyline> _createPolylineFromMarkers(Set<Marker> markers) {
    final polylineCoordinates = markers.map((marker) => marker.position).toList();

    final polyline = Polyline(
      polylineId: const PolylineId('route'),
      color: Colors.blueAccent,
      points: polylineCoordinates,
      width: 5,
    );

    return {polyline};
  }

  Future<void> _startNavigation(Set<Marker> markers) async {
    if (_mapController == null || markers.isEmpty) return;

    List<LatLng> route = markers.map((marker) => marker.position).toList();
    int index = 0;

    _timer = Timer.periodic(const Duration(seconds: 2), (timer) async {
      if (index < route.length) {
        _currentPosition = route[index];
        setState(() {
          _markers.add(Marker(
            markerId: const MarkerId('current_position'),
            position: _currentPosition!,
          ));
        });
        await _mapController!.animateCamera(CameraUpdate.newLatLng(_currentPosition!));
        index++;
      } else {
        _stopNavigation();
      }
    });
  }

  void _stopNavigation() {
    _timer?.cancel();
    _timer = null;
  }

  @override
  void dispose() {
    _stopNavigation();
    super.dispose();
  }
}

