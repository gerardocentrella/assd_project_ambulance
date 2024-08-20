import 'package:flutter/material.dart';
import 'package:assd_project_ambulance/widgets/appbar.dart';
import 'package:assd_project_ambulance/pages/cards/driver_card.dart';
import 'package:assd_project_ambulance/pages/cards/operator_card.dart';


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
    if(index == 2){
      showDialog(context: context, builder:  (BuildContext context) => Dialog(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Do you want logout?', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold,
                fontSize: 20,),
                textAlign: TextAlign.center),
            const SizedBox(height: 30),
             Center(
                 child: Row(
                   mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                       TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, '/login');
                        },
                        child: const Text('YES'),
                      ),
                       TextButton(
                         onPressed: () {
                           Navigator.pop(context);
                         },
                         child: const Text('NO'),
                       ),
                     ],
                ),
             ),
          ],
        ),
        ),
      );
    }else{
      setState(() {
        _currentCardIndex = index;
      });
    }

  }

  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: const MyAppbar(title: 'Home Page'),
     bottomNavigationBar: NavigationBar(
       height: 100.0,
       onDestinationSelected: (int index){
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
       ],
     ),
   );
  }
}