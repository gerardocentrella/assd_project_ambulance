// Classe per la seconda Card: card dell'operatore
import 'package:flutter/material.dart';

class OperatorCard extends StatelessWidget {
  const OperatorCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        color: Colors.lightBlue,
        elevation: 5,
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child:  Column(
          children: [
            Container(/*corpo della card*/child: const Text('Eccomi')),
            const Padding(padding: EdgeInsets.symmetric(vertical: 10),),
            Container(
              alignment: Alignment.bottomCenter,
                 child: Row(
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.lightGreen, // Colore di sfondo
                          foregroundColor: Colors.white, // Colore del testo
                        ),
                        child: const Text('Patient reached', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold,)),
                        onPressed: () {
                          Navigator.pushNamed(context, '/patientreached');
                        },
                      ),
                      const Padding(padding: EdgeInsets.symmetric(horizontal: 53)),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.lightGreen, // Colore di sfondo
                          foregroundColor: Colors.white, // Colore del testo
                        ),
                        child: const Text('PS Reached', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold,)),
                        onPressed: () {
                        },
                      ),
                    ],
              ),
          ),
        ]
      ),
      ),
    );
  }
}