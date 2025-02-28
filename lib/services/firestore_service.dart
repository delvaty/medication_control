import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/medication.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addUser(String userName) async {
    await _firestore.collection('users').doc(userName).set({"name": userName});
  }

  Future<void> addMedication(String user, Medication medication) async {
    await _firestore
        .collection('users')
        .doc(user)
        .collection('medications')
        .add(medication.toMap());
  }

  Stream<QuerySnapshot> getMedications(String user) {
    return _firestore
        .collection('users')
        .doc(user)
        .collection('medications')
        .snapshots();
  }

  Future<void> updateMedication(String user, String id, Medication medication) async {
    await _firestore
        .collection('users')
        .doc(user)
        .collection('medications')
        .doc(id)
        .update(medication.toMap());
  }
}
