
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:medication_control/screens/home/home_screen.dart';
import 'firebase_options.dart';
import 'theme/theme_data.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: myTheme,
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
    );
  }
}

/* class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final CollectionReference usersRef =
      FirebaseFirestore.instance.collection("users");
  /* final FirebaseFirestore _firestore = FirebaseFirestore.instance; */
  List<String> users = ["Abuela", "Abuelo"];

  // Función para eliminar un usuario
  void deleteUser(String id) {
    usersRef.doc(id).delete();
  }

  //Función para mostrar diálogo de edición
  void editUser(String id, String currentName) {
    TextEditingController controller = TextEditingController(text: currentName);

    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Editar Usuario"),
              content: TextField(controller: controller),
              actions: [
                TextButton(
                    onPressed: () {
                      usersRef.doc(id).update({"name": controller.text});
                      Navigator.pop(context);
                    },
                    child: Text("Guardar"))
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de Usuarios"),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: usersRef.snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          final users = snapshot.data!.docs;
          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              var user = users[index];
              return ListTile(
                title: Text(user["name"]),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                        onPressed: () => editUser(user.id, user["name"]),
                        icon: Icon(Icons.edit, color: Colors.blue)),
                    IconButton(
                        onPressed: () => deleteUser(user.id),
                        icon: Icon(Icons.delete, color: Colors.red))
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddUserScreen()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class Medication {
  final String name;
  final String dose;
  final String time;
  bool taken;

  Medication({
    required this.name,
    required this.dose,
    required this.time,
    this.taken = false,
  });
} */
