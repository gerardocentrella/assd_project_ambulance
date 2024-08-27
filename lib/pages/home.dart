import 'package:flutter/material.dart';
import 'package:assd_project_ambulance/widgets/appbar.dart';
import 'package:assd_project_ambulance/pages/cards/driver_card.dart';
import 'package:assd_project_ambulance/pages/cards/operator_card.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../controllers/auth/bloc/auth_bloc.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const Home());
  }

  @override
  _HomeState createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  int _currentCardIndex = 0;

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
        children: const [
          DriverCard(),
          OperatorCard(),
        ],
      ),
    );
  }
}
