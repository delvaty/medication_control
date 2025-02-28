import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../medications/user_medication_screen.dart';
import '../../users/add_user_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  
  int _selectedIndex = 0; // índice de la pestaña seleccionada y guarda que pestaña está seleccionada en el ButtonNavigatorBar
  
 // Actualiza _selectedIndex cuando el usuario toca un ícono en la barra de navegación 
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Cambia la pestaña cuando el usuario toca una opción
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Control de Medicamentos')),
      body: _buildPageContent(),  // Muestra el contenido según la pestaña seleccionada
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.medication),
            label: 'Medicamentos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.more_vert),
            label: 'Más',
          ),
        ],
        currentIndex: _selectedIndex, // Indica que pestña está activa
        selectedItemColor: Theme.of(context).primaryColor, // Color del ícono seleccionado
        onTap: _onItemTapped,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddUserScreen(),
            ),
            ),
        child: const Icon(Icons.add),
      ),
    );
  }


  // Los métodos que empiezan con _build suelen usarse para descomponer partes de la interfaz de usuario en funciones más pequeñas y reutilizables
// Este método genera el contenido de la pantalla dependiendo de _selectedIndex
  Widget _buildPageContent() {
    if (_selectedIndex == 0) {
      return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("users").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Error: ${snapshot.error}"),
            );
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text("No hay usuarios"),
            );
          }
          // docs es una lista (List<QueryDocumentSnapshot>) que contiene todos los documentos dentro de la colección "users"
          // ! se usa para decirle a Dart que data nunca será null en este punto.
          final users = snapshot.data!.docs; // Se obtienen los documentos(docs)de la colección de usuarios en Firebase Firestore
          return ListView(
            children: users.map((doc) {
              final userData = doc.data() as Map<String, dynamic>; // Esto convierte los datos del documento en un mapa de tipo Map<String, dynamic>, para que luego se pueda acceder al nombre del usuario con userData["name"].
              return ListTile(
                
                title: Text(userData["name"]),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        UserMedicationScreen(user: userData["name"]),
                        
                  ),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => AddUserScreen(userID: doc.id, userData: userData),
                      ),
                      );
                    }, icon: Icon(Icons.edit, color: Colors.blue,)
                    ),
                    IconButton(onPressed: () {
                      _confirmDeleteUser(doc.id);
                    }, icon: Icon(Icons.delete, color: Colors.red,))
                  ],
                ),
              );
            }).toList(),
          );
        },
      );
    } else if(_selectedIndex == 1){
      return Center(child: Text("Página de Medicamentos"),);
    } else{
      return Center(child: Text("Más opciones"),);
    }
  }

  void _confirmDeleteUser(String userId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Eliminar Usuario"),
        content: const Text("¿Estás seguro de que quieres eliminar este usuario?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancelar"),
          ),
          TextButton(
            onPressed: () {
              FirebaseFirestore.instance.collection("users").doc(userId).delete();
              Navigator.pop(context);
            },
            child: const Text("Eliminar", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
  
}

