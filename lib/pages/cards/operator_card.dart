// Classe per la seconda Card: card dell'operatore
import 'package:flutter/material.dart';

class OperatorCard extends StatelessWidget {
  const OperatorCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        color: Colors.indigo,
        shadowColor: Colors.lightGreen,
        elevation: 5,
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text('This is Content 2 inside a Card', style: TextStyle(fontSize: 24),),
        ),
      ),
    );
  }
}