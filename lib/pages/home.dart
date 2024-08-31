import 'package:assd_project_ambulance/controllers/message_controller.dart';
import 'package:assd_project_ambulance/models/dto/EmergencyDTO.dart';
import 'package:flutter/material.dart';
import 'package:assd_project_ambulance/pages/cards/driver_card.dart';
import 'package:assd_project_ambulance/pages/cards/operator_card.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../controllers/auth/bloc/auth_bloc.dart';
import '../controllers/emergency/emergency_bloc.dart';
import '../controllers/emergency/emergency_state.dart';
import '../controllers/path/path_bloc.dart';
import '../controllers/path/path_state.dart';
import '../models/dto/PathDTO.dart';

class Home extends StatefulWidget {
  /*
  static const ambulanceId = "AMB00001";
  static String emergencyURL =
      'ws://172.31.4.63:31656/emergencyNotifier/websocket/ambulances/$ambulanceId/emergencies';
  static String pathURL =
      'ws://172.31.4.63:30202/pathNotifier/websocket/ambulances/$ambulanceId/path';


   */
  Home({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => Home());
  }

  @override
  _HomeState createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  //EmergencyDTO? lastEmergency;
  //PathDTO? lastPath;
  //late MessageController _messageController;

  int _currentCardIndex = 0;

  @override
  void initState() {
    super.initState();
    /*
    _messageController = context.read<MessageController>();

    _messageController.openEmergencyStream(Home.emergencyURL);
    _messageController.openPathStream(Home.pathURL);


    _messageController.emergencyStream.listen((EmergencyDTO emergency) {
      context.read<EmergencyBloc>().add(EmergencyReceived(emergency));
    });

    _messageController.pathStream.listen((PathDTO path) {
      setState(() {
        lastPath = path; // Aggiorna il lastPath con quello ricevuto
      });
    });

    // Simuliamo ricezione emergenza e path
    _simulateEmergencyReceiving();
    //_simulatePathReceiving(); // Nuova funzione di simulazione per il path


     */
  }

  /*
  // Funzione di simulazione d'emergenza
  void _simulateEmergencyReceiving() {
    print("HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH");
    // Simula la ricezione di un'emergenza dopo 2 secondi
    Future.delayed(const Duration(seconds: 5), () {
      print("SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS");
        EmergencyDTO emergency = EmergencyDTO(
          emergency: Emergency(
            id: '12345',
            userPosition: Position(latitude: 45.0, longitude: 9.0),
            emergencyCode: EmergencyCode.WHITE,
            description: 'Boh!!.',
            emergencyStatus: EmergencyStatus.ER_SELECTED,
            emergencyType: EmergencyType.C19_ALTRA_PATOLOGIA,
            ambulanceId: 'AMB',
            erId: '001',
          ),
        );
      // Invia gli eventi al bloc all'atto della ricezione dell'emergenza.
      context.read<EmergencyBloc>().add(EmergencyReceived(emergency));
    });
  }


   */


  void _onNavigationButtonPressed(int index) {
    if (index == 2) {
      showDialog(
        context: context,
        builder: (BuildContext context) => Dialog(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 30),
              const Text('Do you want logout?',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.center),
              const SizedBox(height: 30),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        context
                            .read<AuthenticationBloc>()
                            .add(AuthenticationLogoutPressed());
                      },
                      child: const Text(
                        'YES',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'NO',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      setState(() {
        _currentCardIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        centerTitle: true,
        backgroundColor: Colors.red,
        elevation: 100,
        toolbarHeight: 70,
        titleTextStyle: const TextStyle(
            color: Colors.white, fontSize: 30, fontStyle: FontStyle.normal),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15.0),
                bottomRight: Radius.circular(15.0))),
      ),
      bottomNavigationBar: NavigationBar(
        height: 100.0,
        onDestinationSelected: (int index) {
          print(index);
          _onNavigationButtonPressed(index);
        },
        indicatorColor: Colors.amber,
        selectedIndex: _currentCardIndex,
        destinations: const <Widget>[
          NavigationDestination(
            icon: Icon(Icons.map),
            label: 'Driver',
          ),
          NavigationDestination(
            icon: Icon(Icons.medical_services),
            label: 'Operator',
          ),
          NavigationDestination(
            label: ('LogOut'),
            icon: Icon(Icons.logout),
          )
        ],
      ),
      body: IndexedStack(
        index: _currentCardIndex,
        children: [
          DriverCard(),

/*
          BlocBuilder<PathBloc, PathState>(
            builder: (context, state) {
              if(state is PathListening) {
                return  DriverCard(path: null);
              }
              else if (state is PathProcessing){
                return DriverCard(path: state.path);
              }
              else {
                return DriverCard(path: null);
              }
            },
          ),


 */

          // gestione bloc emergenza
          BlocBuilder<EmergencyBloc, EmergencyState>(
            builder: (context, state) {
              if(state is EmergencyListening) {
                return OperatorCard(emergency: null);
              }
              else if (state is EmergencyProcessing){
                return OperatorCard(emergency: state.emergency);
              }
              else {
                return OperatorCard(emergency: null);
              }
            },
          ),
        ],
      ),
    );
  }
}
