import 'package:flutter/material.dart';

import '../../models/medication.dart';

class EditMedicationScreen extends StatefulWidget {
  final Medication medication;
  final Function(Medication) onMedicationUpdated;

  const EditMedicationScreen({
    super.key,
    required this.medication,
    required this.onMedicationUpdated,
  });

  @override
  State <EditMedicationScreen> createState() => EditMedicationScreenState();
}

class EditMedicationScreenState extends State<EditMedicationScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _doseController;
  late TextEditingController _timeController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.medication.name);
    _doseController = TextEditingController(text: widget.medication.dose);
    _timeController = TextEditingController(text: widget.medication.time);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _doseController.dispose();
    _timeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Editar Medicamento"),
        /* actions: [
          IconButton(
              onPressed: () {
                _showDeleteConfirmationDialog(context);
              },
              icon: Icon(Icons.delete))
        ], */
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration:
                      InputDecoration(labelText: "Nombre del medicamento"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Por favor ingresa un nombre";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _doseController,
                  decoration: InputDecoration(labelText: "Dosis"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Por favor ingresa la dosis";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _timeController,
                  decoration: InputDecoration(labelText: "Horario (HH:MM)"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Por favor ingresa un horario";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final updatedMedication = Medication(
                        name: _nameController.text,
                        dose: _doseController.text,
                        time: _timeController.text,
                        taken: widget.medication.taken,
                      );
                      widget.onMedicationUpdated(updatedMedication);
                      Navigator.pop(context);
                    }
                  },
                  child: Text("Guardar Cambios"),
                ),
              ],
            )),
      ),
    );
  }
}

