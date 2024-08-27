import 'package:assd_project_ambulance/controllers/patient_controller.dart';
import 'package:assd_project_ambulance/models/entities/Emergency.dart';
import 'package:assd_project_ambulance/utils/enum_menu_code.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../controllers/patient_reached/patient_reached_bloc.dart';
import '../../controllers/patient_reached/patient_reached_event.dart';
import '../../controllers/patient_reached/patient_reached_state.dart';

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
  late EmergencyCode emerCode;

  TextEditingController nameController = new TextEditingController();
  TextEditingController surnameController = new TextEditingController();
  TextEditingController cityController = new TextEditingController();
  TextEditingController addressController = new TextEditingController();
  TextEditingController ageController = new TextEditingController();
  TextEditingController latitudeController = new TextEditingController();
  TextEditingController longitudeController = new TextEditingController();
  TextEditingController emerDescController = new TextEditingController();


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
      body:  BlocProvider(
        //create: (_) => PatientReachedBloc(),
        create: (context) => PatientReachedBloc.of(context),
          child: BlocListener<PatientReachedBloc, PatientReachedState>(
              listener: (context, state) {
                print("sono nel listener");
                if (state is PatientReachedSuccess) {
                  print("sono nel if del form");
                  ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Data submitted successfully!')),
                  );
                } else if (state is PatientReachedFailure) {
                  ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Error: ${state.error}')),
                  );
                }
              },
              child: Scrollbar(
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
                                        controller: nameController,
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
                                        controller: surnameController,
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
                                        controller: cityController,
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
                                        controller: addressController,
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
                                        controller: ageController,
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
                                        controller: latitudeController,
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
                                        controller: longitudeController,
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
                                        InputDecorator(
                                          decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(15.0),
                                          ),
                                            labelStyle: const TextStyle(
                                              color: Colors.black,
                                              fontStyle: FontStyle.normal,
                                            )),
                                           child: DropdownMenu<EmergencyCodeLabel>(
                                              width: double.maxFinite,
                                              requestFocusOnTap: true,
                                              initialSelection: selectedCode,
                                              label: const Text('Code'),
                                              onSelected: (EmergencyCodeLabel? code) {
                                                setState(() {
                                                  selectedCode = code!;
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
                                            ),),
                                        SizedBox(
                                          height: height * 0.03,
                                        ),
                                         InputDecorator(
                                           decoration: InputDecoration(
                                               border: OutlineInputBorder(
                                                 borderRadius: BorderRadius.circular(15.0),
                                               ),
                                               labelStyle: const TextStyle(
                                                 color: Colors.black,
                                                 fontStyle: FontStyle.normal,
                                               )
                                           ),
                                           child:  DropdownMenu<EmergencyType>(
                                              width: double.maxFinite,
                                              initialSelection: selectedType,
                                              requestFocusOnTap: true,
                                              label: const Text('Type'),
                                              onSelected: (EmergencyType? type) {
                                                setState(() {
                                                  selectedType = type!;
                                                });
                                              },
                                              dropdownMenuEntries: EmergencyType.values
                                                  .map<DropdownMenuEntry<EmergencyType>>(
                                                      (EmergencyType type) {
                                                return DropdownMenuEntry<EmergencyType>(
                                                    value: type, label: type.name);
                                              }).toList(),
                                            ),
                                         ),
                                        SizedBox(
                                          height: height * 0.03,
                                        ),
                                        TextFormField(
                                          controller: emerDescController,
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
                                        context.read<PatientReachedBloc>().add(SubmitPatientData(
                                          name: nameController.text,
                                          surname: surnameController.text,
                                          city: cityController.text,
                                          address: addressController.text,
                                          age: int.parse(ageController.text),
                                          latitude: double.parse(latitudeController.text),
                                          longitude: double.parse(longitudeController.text),
                                          emerCode: getEmergencyCode(selectedCode!.label),
                                          type: selectedType!,
                                          emergencyDescription: emerDescController.text,
                                        ));
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
                ),
              ),
    );
  }
}
