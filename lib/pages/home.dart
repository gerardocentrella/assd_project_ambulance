import 'package:flutter/material.dart';
import 'package:assd_project_ambulance/widgets/appbar.dart';


class Home extends StatefulWidget{
  const Home({super.key});

  @override
  _HomeState createState(){
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  int currentCardIndex = 0;

  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: const MyAppbar(title: 'Home Page'),
     bottomNavigationBar: NavigationBar(
       height: 100.0,
       onDestinationSelected: (int index){
         setState(() {
           currentCardIndex = index;
         });
       },
       indicatorColor: Colors.amber,
       selectedIndex: currentCardIndex,
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
   );
  }
}