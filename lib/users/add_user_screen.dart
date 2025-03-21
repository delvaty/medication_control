import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:medication_control/models/users.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

class AddUserScreen extends StatefulWidget {
  final String? userID; //Puede ser nulo si estamos agregando un usuario nuevo
  final Map<String, dynamic>? userData; // Datos del usuario si es edición

  const AddUserScreen({super.key, this.userID, this.userData});

  @override
  State<AddUserScreen> createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  final _formKey =
      GlobalKey<FormState>(); // Identifica el formulario y permite validaciones
  final _nameController =
      TextEditingController(); // Controlan los campos de texto que permite acceder al contenido del campo de texto y facilita limpiar el campo
  final _lastNameController = TextEditingController();
  String _gender = "Masculino";
  DateTime _dateOfBirth = DateTime(2000);
  final CollectionReference usersCollection = FirebaseFirestore.instance
      .collection("users"); // Referencia a la colección "users" en Firestore

  @override
  void initState() {
    super.initState();
    // Si estamos editando, precargar los datos en los campos de texto
    if (widget.userData != null) {
      _nameController.text = widget.userData!['name'] ?? '';
      _lastNameController.text = widget.userData!['lastname'] ?? '';
      _gender = widget.userData!['gender'] ?? 'Masculino';

      // Verifica si dateOfBirth es nulo o no es un Timestamp
      if (widget.userData!['dateOfBirth'] != null &&
          widget.userData!['dateOfBirth'] is Timestamp) {
        _dateOfBirth = (widget.userData!['dateOfBirth'] as Timestamp).toDate();
      } else {
        _dateOfBirth = DateTime(2000);
      }
    }
  }

  void _saveUser(BuildContext context) {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    try {
      Person person = Person(
        id: widget.userID ?? "",
        name: _nameController.text.trim(),
        lastname: _lastNameController.text.trim(),
        gender: _gender,
        dateOfBirth: _dateOfBirth,
      );

      if (widget.userID == null) {
        // Agregar nuevo usuario
        usersCollection.add(person.toMap());
      } else {
        // Editar usuario existente
        usersCollection.doc(widget.userID).update(person.toMap());
      }
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.fixed,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
              title: "Éxito",
              message: "Usuario guardado correctamente",
              contentType: ContentType.success)));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.fixed,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            title: 'Error',
            message: 'Error, no se ha podido guardar el usuario: $e',
            contentType: ContentType.failure,
          ),
        ),
      );
    }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title:
            Text(widget.userID == null ? 'Agregar Usuario' : "Editar usuario"),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Card(
          elevation: 4,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Form(
              key: _formKey, // Asociamos el form con la clave
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: "Nombre del usuario",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    prefixIcon: Icon(Icons.person),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "El nombre no puede estar vacío";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _lastNameController,
                  decoration: InputDecoration(
                    labelText: "Apellido del usuario",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    prefixIcon: Icon(Icons.person_outline),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "El apellido no puede estar vacío";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                // Selección del género
                DropdownButtonFormField<String>(
                  value: _gender,
                  decoration: InputDecoration(
                    labelText: 'Género',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    prefixIcon: Icon(Icons.wc),
                  ),
                  items: ['Masculino', 'Femenino'].map((String value) {
                    return DropdownMenuItem<String>(
                      // Selector de género
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _gender = value!;
                    });
                  },
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () async {
                          final DateTime? picked = await showDatePicker(
                              context: context,
                              initialDate: _dateOfBirth,
                              firstDate: DateTime(2000),
                              lastDate: DateTime.now());
                          if (picked != null) {
                            setState(() {
                              _dateOfBirth = picked;
                            });
                          }
                        },
                        icon: Icon(Icons.calendar_today),
                        label: Text(
                            "Seleccionar fecha de nacimiento: ${_dateOfBirth.toString().split(" ")[0]}"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.teal.shade300,
                          foregroundColor: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () => _saveUser(context),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                          vertical: 14,
                        ),
                        backgroundColor: Colors.teal,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      child: Text(
                        widget.userID == null
                            ? "Agregar usuario"
                            : "Actualiza usuario",
                        style: TextStyle(fontSize: 16),
                      )),
                )

                // Selección de fecha de nacimiento
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
