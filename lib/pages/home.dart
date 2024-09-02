import 'package:flutter/material.dart';
import 'package:assd_project_ambulance/pages/cards/driver_card.dart';
import 'package:assd_project_ambulance/pages/cards/operator_card.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../controllers/auth/bloc/auth_bloc.dart';
import '../controllers/emergency/emergency_bloc.dart';
import '../controllers/emergency/emergency_state.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const Home());
  }

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentCardIndex = 0;

  @override
  void initState() {
    super.initState();
    // Inizializzazione eventuale
  }

  void _onNavigationButtonPressed(int index) {
    if (index == 2) {
      _showLogoutDialog();
    } else {
      setState(() {
        _currentCardIndex = index;
      });
    }
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) => Dialog(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 30),
            const Text('Do you want to logout?',
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
                      Navigator.pop(context);  // Chiude il dialogo
                    },
                    child: const Text(
                      'YES',
                      style:
                      TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);  // Chiude il dialogo
                    },
                    child: const Text(
                      'NO',
                      style:
                      TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
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
        onDestinationSelected: _onNavigationButtonPressed,
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
            label: 'LogOut',
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: IndexedStack(
        index: _currentCardIndex,
        children: [
          DriverCard(),
          BlocBuilder<EmergencyBloc, EmergencyState>(
            builder: (context, state) {
              if (state is EmergencyListening) {
                return OperatorCard(emergency: null);
              } else if (state is EmergencyProcessing) {
                return OperatorCard(emergency: state.emergency);
              } else {
                return OperatorCard(emergency: null);
              }
            },
          ),
        ],
      ),
    );
  }
}
