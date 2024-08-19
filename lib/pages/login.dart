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
          shadowColor: Colors.black,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(25.0),
              bottomRight: Radius.circular(25.0)
            )),
          leading: Padding(
            padding: const EdgeInsets.only(left: 10.0),
             child: Image.asset(
              'lib/assets/images/ambulance.png',
              fit: BoxFit.contain,
              ),
          ),
    ),

      body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
                Container(height: 100,),
                Text(' Insert Ambulance ID:', textAlign: TextAlign.center, style: customTextStyle()),
              const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                child: TextField(
                decoration: InputDecoration(
                  filled: true,
                  border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(15.0))),
                  hintText: ' type here',
                  ),
                ),
              ),
              Container(height: 10,),
                Text(' Insert Password:', textAlign: TextAlign.center, style: customTextStyle()),
                  const Padding(padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                    child: TextField(
                    decoration: InputDecoration(
                      filled: true,
                      border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(15.0))),
                      hintText: ' type here',
                   ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                width: 150.0, // Set the desired width
                height: 100.0, // Set the desired height
                  child: ElevatedButton.icon(
                    style:  ElevatedButton.styleFrom(
                      textStyle: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                      ),
                      foregroundColor: Colors.black,
                      shadowColor: Colors.black,
                      shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15.0)), // Angoli squadrati
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0), // Spaziatura interna
                      ),
                    onPressed: (){

                    },
                    icon: const Icon(Icons.login),
                    label: const Text('LogIn'),

                  ),
              ),
            ],
          ),
    );
  }
}