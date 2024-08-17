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
      appBar: AppBar(title: const Text('LogIn'), centerTitle: true, backgroundColor: Colors.white, elevation: 100),
    );
  }
}