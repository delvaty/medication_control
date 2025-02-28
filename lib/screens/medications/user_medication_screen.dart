import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../models/medication.dart';
import 'add_medication_screen.dart';
import 'edit_medications_screen.dart';

class UserMedicationScreen extends StatefulWidget {
  final String user;

  const UserMedicationScreen({super.key, required this.user});

  @override
  State<UserMedicationScreen> createState() => _UserMedicationScreenState();
}

class _UserMedicationScreenState extends State<UserMedicationScreen> {
  // Se crea una instancia de FirebaseFirestore para interactuar con Firestore
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

// Método para agregar un medicamento, guarda un nuevo medicamento en Firestore dentro de users/{userId}/medications
  void _addMedication(Medication medication) async {
    try {
      await _firestore
          .collection('users')
          .doc(widget.user)
          .collection('medications')
          .add({
        'name': medication.name,
        'dose': medication.dose,
        'time': medication.time,
        'taken': medication.taken,
      });
    } catch (e) {
      print('Error al guardar el medicamento: $e');
    }
  }

  void _showDeleteConfirmationDialog(BuildContext context, String medicationId) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Eliminar Medicamento"),
          content:
              Text("¿Estás seguro de que quieres eliminar este medicamento"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Cerrar el diálogo
              },
              child: Text("Cancelar"),
            ),
            TextButton(
                onPressed: () async {
                  Navigator.pop(context); // Cerrar el diálogo
                  await _firestore
                  .collection("users")
                  .doc(widget.user)
                  .collection("medications")
                  .doc(medicationId)
                  .delete();
                },
                child: Text(
                  "Eliminar",
                  style: TextStyle(color: Colors.red),
                ))
          ],
        );
      });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Proporciona la estructura básica de una pantalla
      // Barra superior de navegación
      appBar: AppBar(
        title: Text('Medicamentos de ${widget.user}'),
        centerTitle: true,
      ),
      /* El StreamBuilder es un widget que escucha un Stream de datos en tiempo real, puedo escuchar cambios en Firestore en tiempo real, mostrar un CircularProgressIndicator mientras carga:
       Propiedades importantes:
       stream: flujo de datos que observa
       builder Función que construye el widget según los datos recibidos
       */
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore
            .collection('users')
            .doc(widget.user)
            .collection('medications')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          // Si hay datos, se extraen y se muestran en una lista
          final medications =
              snapshot.data!.docs; // Obtiene la lista de dcoumento de Firestore
          //Contruye la lista de medicamentos dinámicamente
          return ListView.builder(
            itemCount: medications.length,
            itemBuilder: (context, index) {
              final medication = medications[index];
              final data = medication.data() as Map<String, dynamic>;
              // Cada medicamentose muestra dentro de una Card con un ListTitle
              return Card(
                child: ListTile(
                  title: Text(data['name']),
                  subtitle: Text("${data['dose']} - ${data['time']}"),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      /* Permite actualizar en Firebase si el medicamento fue tomado
                      value: data["taken"]- Obtiene el estado actual(true o false)
                      onCanged: Actualiza Firestore cuando el user marca/desmarca el checkbox
                       */
                      Checkbox(
                        value: data['taken'],
                        onChanged: (value) async {
                          await _firestore
                              .collection('users')
                              .doc(widget.user)
                              .collection('medications')
                              .doc(medication.id)
                              .update({'taken': value});
                        },
                      ),
                      IconButton(
                        onPressed: () async {
                          final result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditMedicationScreen(
                                medication: Medication(
                                  name: data['name'],
                                  dose: data['dose'],
                                  time: data['time'],
                                  taken: data['taken'],
                                ),
                                onMedicationUpdated: (updatedMedication) async {
                                  await _firestore
                                      .collection('users')
                                      .doc(widget.user)
                                      .collection('medications')
                                      .doc(medication.id)
                                      .update({
                                    'name': updatedMedication.name,
                                    'dose': updatedMedication.dose,
                                    'time': updatedMedication.time,
                                    'taken': updatedMedication.taken,
                                  });
                                },
                              ),
                            ),
                          );
                          if (result == true) {
                            await _firestore
                                .collection('users')
                                .doc(widget.user)
                                .collection('medications')
                                .doc(medication.id)
                                .delete();
                          }
                        },
                        icon: Icon(Icons.edit, color: Colors.green[400],),
                      ),
                      IconButton(onPressed: ()=> _showDeleteConfirmationDialog(context, medication.id), icon: Icon(Icons.delete, color: Colors.red,))
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AddMedicationScreen(
              onMedicationAdded: _addMedication,
            ),
          ),
        ),
        child: Icon(Icons.add),
      ),
    );
  }
}
