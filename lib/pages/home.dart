import 'package:flutter/material.dart';


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
     appBar: AppBar(title: const Text('Home Page'),
       centerTitle: true,
       backgroundColor: Colors.white,
       elevation: 100,
       toolbarHeight: 70,
       titleTextStyle: const TextStyle(
           color: Colors.indigoAccent,
           fontSize: 30,
           fontStyle: FontStyle.normal),
       shadowColor: Colors.black,
       shape: const RoundedRectangleBorder(
           borderRadius: BorderRadius.only(
               bottomLeft: Radius.circular(25.0),
               bottomRight: Radius.circular(25.0)
           )),
       leading: const Padding(
         padding: EdgeInsets.only(left: 10.0),
         child: Icon(Icons.menu)
       ),
     ),
     body: const Text('Chose your area', textAlign: TextAlign.center, style: TextStyle(
       fontSize: 20.0,
     ))
   );
  }
}