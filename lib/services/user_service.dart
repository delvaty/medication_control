// lib/services/user_service.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medication_control/models/users.dart';


class UserService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Obtener todos los usuarios
  Stream<List<Person>> getUsers() {
    return _firestore.collection('users').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        // Crear un mapa que incluya el ID y todos los datos del documento de Firestore
        final Map<String, dynamic> userData = doc.data();
        userData['id'] = doc.id; // Incluir el ID en el mapa
        return Person.fromMap(userData['id'], userData);
      }).toList();
    });
  }

  // Añadir un usuario
  Future<void> addUser(Person user) {
    return _firestore.collection('users').add(user.toMap());
  }

  // Actualizar un usuario
  Future<void> updateUser(Person user) {
    return _firestore.collection('users').doc(user.id).update(user.toMap());
  }

  // Eliminar un usuario
  Future<void> deleteUser(String userId) {
    return _firestore.collection('users').doc(userId).delete();
  }
}