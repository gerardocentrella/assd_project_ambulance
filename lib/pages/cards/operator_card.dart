import 'package:assd_project_ambulance/controllers/emergency_room_reached_controller.dart';
import 'package:assd_project_ambulance/controllers/path/path_bloc.dart';
import 'package:assd_project_ambulance/controllers/path/path_event.dart';
import 'package:assd_project_ambulance/controllers/services/emergency_room_reached_service.dart';
import 'package:assd_project_ambulance/models/dto/EmergencyDTO.dart';
import 'package:assd_project_ambulance/utils/http_result.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../controllers/emergency/emegency_event.dart';
import '../../controllers/emergency/emergency_bloc.dart';

class OperatorCard extends StatelessWidget {
  final EmergencyDTO? emergency;

  OperatorCard({super.key, this.emergency});

  @override
  Widget build(BuildContext context) {
    // ottengo controller
    final controller = context.read<EmergencyRoomReachedController>();

    return Center(
      child: Card(
        color: Colors.white,
        elevation: 5,
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildActionButton(
                  context,
                  label: 'Patient reached',
                  routeName: '/patientreached',
                  isEnabled: emergency != null, // Attivo se c'è emergenza
                ),
                _buildActionButton(
                  context,
                  label: 'ER Reached',
                  isEnabled: emergency != null, // Attivo se c'è emergenza
                  onPressed: emergency != null ? () async {
                    String textDialog = await _sendNotification(controller);
                    _showDialog(context, textDialog);
                    BlocProvider.of<EmergencyBloc>(context).add(EmergencyEnded());
                    //BlocProvider.of<PathBloc>(context).add(PathEnded());
                  } : null,
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          _buildEmergencyInformation(),
        ]),
      ),
    );
  }

  Future<String> _sendNotification(
      EmergencyRoomReachedController controller) async {
    String emergencyId =
        emergency?.id ?? 'CUSTOM ID'; // Usa l'ID dall'emergenza ricevuta
    HttpResult result =
    await controller.sendEmergencyRoomReachedNotification(emergencyId);
    return (result.data != null && result.httpStatusCode == 200)
        ? 'Notify Successfully!'
        : 'Notify Failed, Try Again..';
  }

  void _showDialog(BuildContext context, String textDialog) {
    showDialog(
      context: context,
      builder: (BuildContext context) => Dialog(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 30),
            Text(
              textDialog,
              style: const TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            )
          ],
        ),
      ),
    );
  }

  ElevatedButton _buildActionButton(BuildContext context,
      {required String? label, String? routeName, VoidCallback? onPressed, bool isEnabled = true}) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(100, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        backgroundColor: isEnabled ? Colors.red : Colors.grey, // Cambia il colore qui
      ),
      onPressed: isEnabled ? (routeName != null ? () {
        Navigator.pushNamed(context, routeName);
      } : onPressed) : null, // Disabilita il pulsante se non è abilitato
      child: Text(
        label!,
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildEmergencyInformation() {
    if (emergency == null) {
      return const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(20.0),
            child: Text(
              'No Emergency Information Available',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          SizedBox(height: 20), // Spazio tra il testo e il caricamento
          CircularProgressIndicator(), // Indicatore di caricamento
        ],
      );
    }
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(color: Colors.grey, spreadRadius: 1, blurRadius: 15),
        ],
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Emergency Information',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
              fontSize: 28.0,
            ),
          ),
          const SizedBox(height: 10),
          _buildInfoRow('ID', emergency?.id ?? 'N/A'),
          _buildInfoRow('Code', emergency?.emergencyCode.name ?? 'N/A'),
          _buildInfoRow('Status', emergency?.emergencyStatus.name ?? 'N/A'),
          _buildInfoRow('Description', emergency?.description ?? 'N/A'),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  Row _buildInfoRow(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          textAlign: TextAlign.start,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
          ),
        ),
        Text(
          value,
          textAlign: TextAlign.start,
          style: const TextStyle(
            color: Colors.black,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.w500,
            fontSize: 20.0,
          ),
        ),
      ],
    );
  }
}
