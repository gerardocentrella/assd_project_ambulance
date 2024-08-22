// Classe per la prima Card: card del guidatore
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DriverCard extends StatelessWidget {
  const DriverCard({Key? key}) : super(key: key);


@override
Widget build(BuildContext context) {
  return Center(
    child: Card(
      color: Colors.indigo,
      shadowColor: Colors.lightGreen,
      elevation: 5,
      margin: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: const Padding(
        padding: EdgeInsets.all(16.0),
        child: GoogleMap(
          onMapCreated: (controller) {
            _mapController = controller;
          },
          initialCameraPosition: CameraPosition(
            target: currentLocation,
            zoom: 8.0,
          ),
          markers: _markers,
        ),
      ),
    ),
  );
  }
}