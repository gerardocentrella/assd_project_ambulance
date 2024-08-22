import 'package:assd_project_ambulance/models/entities/Emergency.dart';
import 'package:assd_project_ambulance/utils/enum_menu_code.dart';
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
  EmergencyCodeLabel? selectedCode;
  EmergencyType? selectedType;

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    // Build a Form widget using the _formKey created above.
    return Scaffold(
      appBar: AppBar(
        title: const Text('Patient Data'),
        centerTitle: true,
        backgroundColor: Colors.red,
        elevation: 100,
        toolbarHeight: 70,
        titleTextStyle: const TextStyle(
            color: Colors.white, fontSize: 30, fontStyle: FontStyle.normal),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15.0),
                bottomRight: Radius.circular(15.0))),
      ),
      body: Scrollbar(
        thickness: 15,
        thumbVisibility: true,
        trackVisibility: true,
        radius: const Radius.circular(10.0),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Container(
              decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.grey, spreadRadius: 1, blurRadius: 15)
                  ],
                  //border: Border.all(width: 2.0),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.0)),
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                        //border: Border.all(width: 2.0),
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            "Insert patient data",
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.red),
                          ),
                          SizedBox(
                            height: height * 0.02,
                          ),
                          TextFormField(
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(15.0))),
                                labelText: 'Patient name',
                                labelStyle: TextStyle(
                                  color: Colors.black,
                                  fontStyle: FontStyle.normal,
                                )),
                            // The validator receives the text that the user has entered.
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: height * 0.03,
                          ),
                          TextFormField(
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(15.0))),
                                labelText: 'Patient Surname',
                                labelStyle: TextStyle(
                                  color: Colors.black,
                                  fontStyle: FontStyle.normal,
                                )),
                            // The validator receives the text that the user has entered.
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: height * 0.03,
                          ),
                          TextFormField(
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(15.0))),
                                labelText: 'City',
                                labelStyle: TextStyle(
                                  color: Colors.black,
                                  fontStyle: FontStyle.normal,
                                )),
                            // The validator receives the text that the user has entered.
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: height * 0.03,
                          ),
                          TextFormField(
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(15.0))),
                                labelText: 'Address',
                                labelStyle: TextStyle(
                                  color: Colors.black,
                                  fontStyle: FontStyle.normal,
                                )),
                            // The validator receives the text that the user has entered.
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: height * 0.03,
                          ),
                          TextFormField(
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(15.0))),
                                labelText: 'Age',
                                labelStyle: TextStyle(
                                  color: Colors.black,
                                  fontStyle: FontStyle.normal,
                                )),
                            // The validator receives the text that the user has entered.
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                          ),
                        ]),
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                        //border: Border.all(width: 2.0),
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            "Insert current position",
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.red),
                          ),
                          SizedBox(
                            height: height * 0.02,
                          ),
                          TextFormField(
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(15.0))),
                                labelText: 'Latitude',
                                labelStyle: TextStyle(
                                  color: Colors.black,
                                  fontStyle: FontStyle.normal,
                                )),
                            // The validator receives the text that the user has entered.
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: height * 0.03,
                          ),
                          TextFormField(
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(15.0))),
                                labelText: 'Longitude',
                                labelStyle: TextStyle(
                                  color: Colors.black,
                                  fontStyle: FontStyle.normal,
                                )),
                            // The validator receives the text that the user has entered.
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                          ),
                        ]),
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                          //border: Border.all(width: 2.0),
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              "Insert emergency data",
                              style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red),
                            ),
                            SizedBox(
                              height: height * 0.03,
                            ),
                            DropdownMenu<EmergencyCodeLabel>(
                              inputDecorationTheme: const InputDecorationTheme(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15.0))),
                                  labelStyle: TextStyle(
                                    color: Colors.black,
                                    fontStyle: FontStyle.normal,
                                  )),
                              width: double.infinity,
                              requestFocusOnTap: true,
                              initialSelection: EmergencyCodeLabel.red,
                              label: const Text('Code'),
                              onSelected: (EmergencyCodeLabel? code) {
                                setState(() {
                                  selectedCode = code;
                                });
                              },
                              dropdownMenuEntries: EmergencyCodeLabel.values
                                  .map<DropdownMenuEntry<EmergencyCodeLabel>>(
                                      (EmergencyCodeLabel code) {
                                return DropdownMenuEntry<EmergencyCodeLabel>(
                                    value: code,
                                    label: code.label,
                                    style: MenuItemButton.styleFrom(
                                        foregroundColor: code.color,
                                        backgroundColor: Colors.black12));
                              }).toList(),
                            ),
                            SizedBox(
                              height: height * 0.03,
                            ),
                            DropdownMenu<EmergencyType>(
                              inputDecorationTheme: const InputDecorationTheme(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15.0))),
                                  labelStyle: TextStyle(
                                    color: Colors.black,
                                    fontStyle: FontStyle.normal,
                                  )),
                              width: double.infinity,
                              initialSelection: EmergencyType.C01_TRAUMATICA,
                              requestFocusOnTap: true,
                              label: const Text('Type'),
                              onSelected: (EmergencyType? type) {
                                setState(() {
                                  selectedType = type;
                                });
                              },
                              dropdownMenuEntries: EmergencyType.values
                                  .map<DropdownMenuEntry<EmergencyType>>(
                                      (EmergencyType type) {
                                return DropdownMenuEntry<EmergencyType>(
                                    value: type, label: type.name);
                              }).toList(),
                            ),
                            SizedBox(
                              height: height * 0.03,
                            ),
                            TextFormField(
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15.0))),
                                  labelText: 'Emergency Description',
                                  labelStyle: TextStyle(
                                    color: Colors.black,
                                    fontStyle: FontStyle.normal,
                                  )),
                              // The validator receives the text that the user has entered.
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter some text';
                                }
                                return null;
                              },
                            ),
                          ])),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          minimumSize: const Size(100, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          )),
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
                      child: const Text(
                        'Submit',
                        style: TextStyle(
                            color: Colors.black, fontStyle: FontStyle.normal),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
