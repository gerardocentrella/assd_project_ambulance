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

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BlocListener<GpsBloc, GpsState>(
        listener: (context, state) async {
          if (state is GpsOnPatient || state is GpsOnPS) {
            // Fetch positions from a method like `_retrievePositions()`
            _markers =  state.markers;
            _polylines = _createPolylineFromMarkers(_markers);

            setState(() {});

            // Start navigation after setting the markers and polylines
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
            child: FutureBuilder<Position?>(
              future: context.read<PositionRepository>().status,
              builder: (BuildContext context, AsyncSnapshot<Position?> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return const Text("Errore nel recupero della posizione");
                } else if (snapshot.hasData && snapshot.data != null) {
                  Position position = snapshot.data!;
                  LatLng currentPosition = LatLng(position.latitude, position.longitude);

                  // Add the current position marker
                  _markers.add(
                    Marker(
                      markerId: const MarkerId('current_position'),
                      position: currentPosition,
                      infoWindow: const InfoWindow(title: 'Ambulanza'),
                    ),
                  );

                  _polylines = _createPolylineFromMarkers(_markers);

                  return GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: currentPosition,
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

  // Function to create markers from positions
  Set<Marker> _createMarkersFromPositions(List<Position> positions) {
    Set<Marker> markers = {};
    for (var i = 0; i < positions.length; i++) {
      markers.add(
        Marker(
          markerId: MarkerId('marker_$i'),
          position: LatLng(positions[i].latitude, positions[i].longitude),
        ),
      );
    }
    return markers;
  }

  // Function to create polyline from markers
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

  // Function to start navigation from start to end position
  Future<void> _startNavigation(Set<Marker> markers) async {
    if (_mapController == null || markers.isEmpty) return;

    // Convert markers to a sorted list based on a logical path (if required)
    List<Marker> sortedMarkers = markers.toList();

    // Simulate navigation by moving the camera along the route
    for (var marker in sortedMarkers) {
      await Future.delayed(const Duration(seconds: 2));
      await _mapController!.animateCamera(CameraUpdate.newLatLng(marker.position));
    }
  }

}
