import 'package:flutter/material.dart';

import '../../models/medication.dart';

class AddMedicationScreen extends StatefulWidget {
  final Function(Medication) onMedicationAdded;

  const AddMedicationScreen({super.key, required this.onMedicationAdded});

  @override
  State<AddMedicationScreen> createState() => _AddMedicationScreenState();
}

class _AddMedicationScreenState extends State<AddMedicationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _doseController = TextEditingController();
  final _timeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Agregar Medicamento')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration:
                    InputDecoration(labelText: 'Nombre del medicamento'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa un nombre';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _doseController,
                decoration: InputDecoration(labelText: 'Dosis'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa la dosis';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _timeController,
                decoration: InputDecoration(labelText: 'Horario (HH:MM)'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa un horario';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final medication = Medication(
                      name: _nameController.text,
                      dose: _doseController.text,
                      time: _timeController.text,
                      taken: false,
                    );
                    widget.onMedicationAdded(medication);
                    Navigator.pop(context);
                  }
                },
                child: Text('Agregar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}