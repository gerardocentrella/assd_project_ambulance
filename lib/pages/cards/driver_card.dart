import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import '../../controllers/gps/gps_bloc.dart';
import '../../models/repository/position_repository.dart';

class DriverCard extends StatefulWidget {
  //final PathDTO? path;
  //late final List<Position>? positions;
  DriverCard({Key? key}) : super(key: key) {
    //positions = path?.path.cast<Position>();
  }

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
        _initialPosition = currentPosition;
        _generateRoute();
      }

      setState(() {
        _updateMarkersAndPolylines(currentPosition);
      });

      if (_mapController != null) {
        _mapController!.animateCamera(CameraUpdate.newLatLng(currentPosition));
      }
    });
  }

  void _updateMarkersAndPolylines(LatLng currentPosition) {
    setState(() {
      _markers = {
        Marker(
          markerId: const MarkerId('current_position'),
          position: currentPosition,
          infoWindow: const InfoWindow(title: 'Ambulanza'),
        ),
      };
      _polylines = _createPolylineFromMarkers(_markers);
    });
  }

  void _generateRoute() {
    if (_initialPosition == null) return;

    List<LatLng> routePoints = [
      _initialPosition!,
      LatLng(40.682441, 14.505223),
      LatLng(40.630387, 14.602920),
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
      _markers.addAll(routePoints.asMap().entries.map((entry) {
        int index = entry.key;
        LatLng point = entry.value;
        return Marker(
          markerId: MarkerId('marker_$index'),
          position: point,
          infoWindow: InfoWindow(title: 'Point ${index + 1}'),
        );
      }));
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

  Set<Polyline> _createPolylineFromMarkers(Set<Marker> markers) {
    final polylineCoordinates = markers.map((marker) => marker.position).toList();

    return {
      Polyline(
        polylineId: const PolylineId('route'),
        color: Colors.blueAccent,
        points: polylineCoordinates,
        width: 5,
      ),
    };
  }

  Future<void> _startNavigation(Set<Marker> markers) async {
    if (_mapController == null || markers.isEmpty) return;

    for (var marker in markers) {
      await Future.delayed(const Duration(seconds: 2));
      if (_mapController != null) {
        await _mapController!.animateCamera(CameraUpdate.newLatLng(marker.position));
      }
    }
  }
}

