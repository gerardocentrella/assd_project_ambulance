import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../controllers/patientFormBloc/patient_form_bloc.dart';
import '../../models/entities/Emergency.dart';
import '../../utils/enum_menu_code.dart';

class PatientReachedForm2 extends StatefulWidget {
  const PatientReachedForm2({super.key});

  @override
  PatientReachedForm2State createState() {
    return PatientReachedForm2State();
  }
}

class PatientReachedForm2State extends State<PatientReachedForm2> {
  final _formKey = GlobalKey<FormState>();
  EmergencyCodeLabel? selectedCode;
  EmergencyType? selectedType;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController surnameController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController latitudeController = TextEditingController();
  final TextEditingController longitudeController = TextEditingController();
  final TextEditingController emerDescController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    surnameController.dispose();
    cityController.dispose();
    addressController.dispose();
    ageController.dispose();
    latitudeController.dispose();
    longitudeController.dispose();
    emerDescController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;

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
      body: BlocListener<PatientFormBloc, PatientFormState>(
          listener: (context, state) {
            if (state is PatientFormLoading) {
              // Potresti voler mostrare un indicatore di caricamento
              print("Loading...");
            } else if (state is PatientFormSuccess) {
              print("Dati inviati con successo!");
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Data submitted successfully!'),
                  duration: Duration(seconds: 2), // Durata di visualizzazione dello Snackbar
                ),
              );
              _resetForm(); // Pulisce il form
            } else if (state is PatientFormFailure) {
              print("Errore: ${state.error}");
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
                        color: Colors.grey,
                        spreadRadius: 1,
                        blurRadius: 15,
                      )
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _buildSectionTitle("Insert patient data", height),
                      _buildTextField(
                          controller: nameController,
                          labelText: 'Patient name'),
                      _buildTextField(
                          controller: surnameController,
                          labelText: 'Patient Surname'),
                      _buildTextField(
                          controller: cityController, labelText: 'City'),
                      _buildTextField(
                          controller: addressController, labelText: 'Address'),
                      _buildTextField(
                          controller: ageController,
                          labelText: 'Age',
                          keyboardType: TextInputType.number),
                      _buildSectionTitle("Insert current position", height),
                      _buildTextField(
                          controller: latitudeController,
                          labelText: 'Latitude',
                          keyboardType: TextInputType.number),
                      _buildTextField(
                          controller: longitudeController,
                          labelText: 'Longitude',
                          keyboardType: TextInputType.number),
                      _buildSectionTitle("Insert emergency data", height),
                      _buildDropdownMenu<EmergencyCodeLabel>(
                        label: 'Code',
                        selectedValue: selectedCode,
                        onChanged: (EmergencyCodeLabel? code) {
                          setState(() {
                            selectedCode = code!;
                          });
                        },
                        items: EmergencyCodeLabel.values,
                      ),
                      _buildDropdownMenu<EmergencyType>(
                        label: 'Type',
                        selectedValue: selectedType,
                        onChanged: (EmergencyType? type) {
                          setState(() {
                            selectedType = type!;
                          });
                        },
                        items: EmergencyType.values,
                      ),
                      _buildTextField(
                          controller: emerDescController,
                          labelText: 'Emergency Description'),
                      _buildSubmitButton(context),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
    );
  }

  void _resetForm() {
    nameController.clear();
    surnameController.clear();
    cityController.clear();
    addressController.clear();
    ageController.clear();
    latitudeController.clear();
    longitudeController.clear();
    emerDescController.clear();
    setState(() {
      selectedCode = null;
      selectedType = null;
    });
  }

  Widget _buildSectionTitle(String title, double height) {
    return Column(
      children: [
        const SizedBox(height: 20.0),
        Text(
          title,
          style: const TextStyle(
              fontSize: 30, fontWeight: FontWeight.bold, color: Colors.red),
        ),
        SizedBox(height: height * 0.02),
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    TextInputType? keyboardType,
  }) {
    return Column(
      children: [
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(15.0)),
            ),
            labelText: labelText,
            labelStyle: const TextStyle(
              color: Colors.black,
              fontStyle: FontStyle.normal,
            ),
          ),
          keyboardType: keyboardType,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter some text';
            }
            return null;
          },
        ),
        const SizedBox(height: 20.0),
      ],
    );
  }

  Widget _buildDropdownMenu<T>({
    required String label,
    required T? selectedValue,
    required ValueChanged<T?> onChanged,
    required List<T> items,
  }) {
    return Column(
      children: [
        InputDecorator(
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            labelStyle: const TextStyle(
              color: Colors.black,
              fontStyle: FontStyle.normal,
            ),
          ),
          child: DropdownButton<T>(
            value: selectedValue,
            isExpanded: true,
            onChanged: onChanged,
            items: items.map<DropdownMenuItem<T>>((T item) {
              return DropdownMenuItem<T>(
                value: item,
                child: Text(item.toString()),
              );
            }).toList(),
          ),
        ),
        const SizedBox(height: 20.0),
      ],
    );
  }

  Widget _buildSubmitButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(100, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            context.read<PatientFormBloc>().add(
              PatientFormEventSubmit(
                name: nameController.text,
                surname: surnameController.text,
                city: cityController.text,
                address: addressController.text,
                age: int.parse(ageController.text),
                latitude: double.parse(latitudeController.text),
                longitude: double.parse(longitudeController.text),
                emerCode: selectedCode!,
                type: selectedType!,
                emergencyDescription: emerDescController.text,
              ),
            );
          }
        },
        child: const Text(
          'Submit',
          style: TextStyle(
              color: Colors.black, fontStyle: FontStyle.normal),
        ),
      ),
    );
  }
}
