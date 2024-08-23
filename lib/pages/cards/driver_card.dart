// Classe per la prima Card: card del guidatore
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import '../../models/repository/position_repository.dart';

class DriverCard extends StatelessWidget {
  const DriverCard({Key? key}) : super(key: key);


@override
Widget build(BuildContext context) {

  Stream<Position> positionAmb = context.read<PositionRepository>().status;

  return Center(
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
        child: StreamBuilder<Position>(
            stream: positionAmb,
            builder: (BuildContext context, AsyncSnapshot<Position> snapshot) {
              Position position = snapshot.requireData;
              if (snapshot.hasData){
                return GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: LatLng(position.latitude, position.longitude),
                    zoom: 8.0,
                  ),
                  markers: const {

                  },
                );
              }
              else {
                return const Text("successe cose");
              }
            }

        )
      ),
    ),
  );
  }
}