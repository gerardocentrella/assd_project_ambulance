import 'package:assd_project_ambulance/controllers/emergency_room_reached_controller.dart';
import 'package:assd_project_ambulance/controllers/services/emergency_room_reached_service.dart';
import 'package:assd_project_ambulance/utils/http_result.dart';
import 'package:flutter/material.dart';

class OperatorCard extends StatelessWidget {
  final String emergencyId = 'CUSTOM ID';
  final EmergencyRoomReachedController _controller =
  EmergencyRoomReachedController(EmergencyRoomReachedService());

  OperatorCard({super.key});

  @override
  Widget build(BuildContext context) {
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
                ),
                _buildActionButton(
                  context,
                  label: 'ER Reached',
                  onPressed: () async {
                    String textDialog = await _sendNotification();
                    _showDialog(context, textDialog);
                  },
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

  ElevatedButton _buildActionButton(BuildContext context,
      {required String label, String? routeName, VoidCallback? onPressed}) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(100, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      onPressed: routeName != null ? () {
        Navigator.pushNamed(context, routeName);
      } : onPressed,
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Future<String> _sendNotification() async {
    HttpResult result = await _controller.sendEmergencyRoomReachedNotification(emergencyId);
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
          ],
        ),
      ),
    );
  }

  Widget _buildEmergencyInformation() {
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
          _buildInfoRow('ID', emergencyId),
          _buildInfoRow('Code', 'ads'),
          _buildInfoRow('Status', 'ads'),
          _buildInfoRow('Description', 'ads'),
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