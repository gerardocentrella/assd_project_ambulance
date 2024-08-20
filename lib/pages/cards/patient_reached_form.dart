import 'package:flutter/material.dart';

// Create a Form widget.
class PatientReachedForm extends StatefulWidget {
  const PatientReachedForm({super.key});

  @override
  PatientReachedFormState createState() {
    return PatientReachedFormState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class PatientReachedFormState extends State<PatientReachedForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final double height= MediaQuery.of(context).size.height;
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height:height*0.04),
          const Text("Insert patient data", style: TextStyle(fontSize: 30, color:Color(0xFF363f93)),),
          SizedBox(height: height*0.05),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Patient Name',
            ),
            // The validator receives the text that the user has entered.
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          SizedBox(height: height*0.05,),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Patient Surname',
            ),
            // The validator receives the text that the user has entered.
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          SizedBox(height: height*0.05,),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'City',
            ),
            // The validator receives the text that the user has entered.
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          SizedBox(height: height*0.05,),
          TextFormField(
            decoration: const InputDecoration(

              labelText: 'Address',
            ),
            // The validator receives the text that the user has entered.
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          SizedBox(height: height*0.05,),
          TextFormField(
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Age',
            ),
            // The validator receives the text that the user has entered.
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          SizedBox(height:height*0.04),
          const Text("Insert current position", style: TextStyle(fontSize: 30, color:Color(0xFF363f93)),),
          SizedBox(height: height*0.05,),
          TextFormField(
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Latitude',
            ),
            // The validator receives the text that the user has entered.
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          SizedBox(height: height*0.05,),
          TextFormField(
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Longitude',
            ),
            // The validator receives the text that the user has entered.
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          SizedBox(height:height*0.04),
          const Text("Insert emergency data", style: TextStyle(fontSize: 30, color:Color(0xFF363f93)),),
          SizedBox(height: height*0.05,),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Emergency Code',
            ),
            // The validator receives the text that the user has entered.
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          SizedBox(height: height*0.05,),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Emergency Type',
            ),
            // The validator receives the text that the user has entered.
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          SizedBox(height: height*0.05,),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Emergency Description',
            ),
            // The validator receives the text that the user has entered.
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: ElevatedButton(
              onPressed: () {
                // Validate returns true if the form is valid, or false otherwise.
                if (_formKey.currentState!.validate()) {
                  // If the form is valid, display a snackbar. In the real world,
                  // you'd often call a server or save the information in a database.
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Processing Data')),
                  );
                }
              },
              child: const Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }
}