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
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: MyAppbar(title: 'home page'),
     body: Column(
        children:[
          Text('Chose your area', textAlign: TextAlign.center, style: TextStyle(
         fontSize: 20.0,)),
          ElevatedButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/login');
          }, 
            child: Text('torna al login'),),
        ],
    ),
   );
  }
}