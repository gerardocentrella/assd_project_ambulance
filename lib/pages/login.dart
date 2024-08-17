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

TextStyle customTextStyle(){
  return const TextStyle(
      fontSize: 30,
      fontWeight: FontWeight.w500,
      color: Colors.black,
      fontStyle: FontStyle.italic
    );
}


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.redAccent,
      appBar: AppBar(title: const Text('Login'),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 100,
          toolbarHeight: 70,
          titleTextStyle: const TextStyle(
            color: Colors.indigoAccent,
            fontSize: 30,
            fontStyle: FontStyle.normal),
          shadowColor: Colors.lightGreenAccent,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(25.0),
              bottomRight: Radius.circular(25.0)
            ))
          ),

      body: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
                Container(
                  height: 100,
                ),
                Text(' Insert Ambulance ID:', textAlign: TextAlign.left, style: customTextStyle()),
              const TextField(
                decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  hintText: ' type here',
                ),
              ),
                Text(' Insert Password:', textAlign: TextAlign.left, style: customTextStyle()),
            const TextField(
              decoration: InputDecoration(
               border: UnderlineInputBorder(),
               hintText: ' type here',
               ),
              ),
            ],
          ),
      ),
    );
  }
}