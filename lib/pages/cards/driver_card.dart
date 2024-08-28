import 'dart:async';
import 'package:assd_project_ambulance/models/dto/PathDTO.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import '../../controllers/gps/gps_bloc.dart';
import '../../models/repository/position_repository.dart';

class DriverCard extends StatefulWidget {
  const DriverCard({Key? key, PathDTO? path}) : super(key: key);

  @override
  _DriverCardState createState() => _DriverCardState();
}

class _DriverCardState extends State<DriverCard> {
  Set<Marker> _markers = {};
  Set<Polyline> _polylines = {};
  GoogleMapController? _mapController;
  StreamSubscription<Position>? _positionSubscription;
  LatLng? _initialPosition;

  @override
  void initState() {
    super.initState();
    _subscribeToPositionStream();
  }

  @override
  void dispose() {
    _positionSubscription?.cancel();
    super.dispose();
  }

  void _subscribeToPositionStream() {
    _positionSubscription = context.read<PositionRepository>().positionStream.listen((Position position) {
      final LatLng currentPosition = LatLng(position.latitude, position.longitude);

      if (_initialPosition == null) {
        _initialPosition = currentPosition; // Set the initial position
        _generateRoute(); // Generate the route based on the initial position
      }

      setState(() {
        _markers.add(
          Marker(
            markerId: const MarkerId('current_position'),
            position: currentPosition,
            infoWindow: const InfoWindow(title: 'Ambulanza'),
          ),
        );

        if (_mapController != null) {
          _mapController!.animateCamera(CameraUpdate.newLatLng(currentPosition));
        }
      });
    });
  }

  void _generateRoute() {
    if (_initialPosition == null) return;

    // Define a few waypoints for the route as an example
    List<LatLng> routePoints = [
      _initialPosition!,
      LatLng(40.682441, 14.505223), // Example: Pompeii
      LatLng(40.630387, 14.602920), // Example: Amalfi
    ];

    setState(() {
      _polylines = {
        Polyline(
          polylineId: const PolylineId('route'),
          color: Colors.blueAccent,
          points: routePoints,
          width: 5,
        ),
      };

      // Create markers for the route
      for (var i = 0; i < routePoints.length; i++) {
        _markers.add(
          Marker(
            markerId: MarkerId('marker_$i'),
            position: routePoints[i],
            infoWindow: InfoWindow(title: 'Point ${i + 1}'),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BlocListener<GpsBloc, GpsState>(
        listener: (context, state) {
          if (state is GpsOnPatient || state is GpsOnPS) {
            setState(() {
              _markers = state.markers;
              _polylines = _createPolylineFromMarkers(_markers);
            });

            if (_markers.isNotEmpty) {
              _startNavigation(_markers);
            }
          } else if (state is GpsOnPause) {
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
            child: _buildGoogleMap(),
          ),
        ),
      ),
    );
  }

  Widget _buildGoogleMap() {
    if (_initialPosition == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return GoogleMap(
      initialCameraPosition: CameraPosition(
        target: _initialPosition!,
        zoom: 14.0,
      ),
      markers: _markers,
      polylines: _polylines,
      onMapCreated: (controller) {
        _mapController = controller;
      },
    );
  }

  // Funzione per creare una polilinea dai markers
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

  // Funzione per avviare la navigazione basata sui markers
  Future<void> _startNavigation(Set<Marker> markers) async {
    if (_mapController == null || markers.isEmpty) return;

    List<Marker> sortedMarkers = markers.toList();

    for (var marker in sortedMarkers) {
      await Future.delayed(const Duration(seconds: 2));
      await _mapController!.animateCamera(CameraUpdate.newLatLng(marker.position));
    }
  }
}
