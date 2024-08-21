// Classe per la seconda Card: card dell'operatore
import 'package:flutter/material.dart';

class OperatorCard extends StatelessWidget {
  const OperatorCard({super.key});

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
            //const Padding(padding: EdgeInsets.all(10.0),),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                  boxShadow: const [BoxShadow(
                      color: Colors.grey,
                      spreadRadius: 1,
                      blurRadius: 15
                  )],
                  //border: Border.all(width: 2.0),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.0)
              ),
              //padding: const EdgeInsets.symmetric(horizontal: 20.0),
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
            const SizedBox(height: 20,),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                  boxShadow: const [BoxShadow(
                      color: Colors.grey,
                      spreadRadius: 1,
                      blurRadius: 15
                  )],
                  //border: Border.all(width: 2.0),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.0)
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Emergency Information',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 28.0
                    ),
                  ),
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'ID',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0
                        ),
                      ),
                      Text(
                        'sd',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: Colors.black,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w500,
                            fontSize: 20.0
                        ),
                      ),

                    ],
                  ),
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Code',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0
                        ),
                      ),
                      Text(
                        'ads',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: Colors.black,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w500,
                            fontSize: 20.0
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Status',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0
                        ),
                      ),
                      Text(
                        'ads',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: Colors.black,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w500,
                            fontSize: 20.0
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Description',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0
                        ),
                      ),
                      Text(
                        'ads',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: Colors.black,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w500,
                            fontSize: 20.0
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10,)

                ],
              ),
            )
        ]
      ),
      ),
    );
  }
}