import 'package:flutter/material.dart';

class Login extends StatefulWidget{
  const Login({super.key});

  @override
  _Login createState(){
    return _Login();
  }

  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _Login extends State<Login> {


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.redAccent,
      appBar: AppBar(title: const Text('My App'),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 100,
          toolbarHeight: 50,
          titleTextStyle: const TextStyle(
            color: Colors.indigoAccent,
            fontSize: 30,
            fontStyle: FontStyle.normal),
          shadowColor: Colors.lightGreenAccent,
          shape: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: Colors.transparent, width: 5),
            gapPadding: 120,)
          )

    );
  }
}