// Classe per la seconda Card: card dell'operatore
import 'package:flutter/material.dart';

class OperatorCard extends StatelessWidget {
  const OperatorCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        color: Colors.white,
        elevation: 5,
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child:  Column(
          children: [
            const Padding(padding: EdgeInsets.all(10.0),),
            Container(

              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              //alignment: Alignment.bottomCenter,
                 child: Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            minimumSize: const Size(100, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            )
                        ),
                        child: const Text('Patient reached', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold,)),
                        onPressed: () {
                          Navigator.pushNamed(context, '/patientreached');
                        },
                      ),
                      //const SizedBox(width: 50,),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            minimumSize: const Size(100, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            )
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