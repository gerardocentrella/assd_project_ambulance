import 'package:flutter/material.dart';

class LogoutCard extends StatelessWidget {
  const LogoutCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.lightBlue,
        child: Center(
          child: Column(
            children: [
              Container(height: 200,),
              const Text('Do you want logOut?', style: TextStyle(fontSize: 24),),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/login');
                }, child: const Text('LogOut'),
              ),
            ],
      ),
    ),
    );
  }
}