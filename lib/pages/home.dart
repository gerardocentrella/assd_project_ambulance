import 'package:flutter/material.dart';
import 'package:assd_project_ambulance/widgets/appbar.dart';
import 'package:assd_project_ambulance/pages/cards/driver_card.dart';
import 'package:assd_project_ambulance/pages/cards/operator_card.dart';
import 'package:assd_project_ambulance/pages/cards/logout_card.dart';


class Home extends StatefulWidget{
  const Home({super.key});

  @override
  _HomeState createState(){
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  int _currentCardIndex = 0;

  void _onNavigationButtonPressed(int index) {
    setState(() {
      _currentCardIndex = index;
    });
  }

  void logOut(){
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: const MyAppbar(title: 'Home Page'),
     bottomNavigationBar: NavigationBar(
       height: 100.0,
       onDestinationSelected: (int index){
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
             label: 'Operator',),
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
           LogoutCard()
       ],
     ),
   );
  }
}