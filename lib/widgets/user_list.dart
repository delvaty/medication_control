// lib/widgets/user_list.dart
import 'package:flutter/material.dart';
import 'package:medication_control/models/users.dart';
import 'package:medication_control/users/add_user_screen.dart';

import '../screens/medications/user_medication_screen.dart';

class UserList extends StatelessWidget {
  final List<Person> users;
  final Function(String) onDeleteUser;

  const UserList({
    super.key,
    required this.users,
    required this.onDeleteUser,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (context, index) {
        final user = users[index];
        return ListTile(
          title: Text(user.name),
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => UserMedicationScreen(user: user.name),
            ),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddUserScreen(
                        userID: user.id,
                        userData: {'name': user.name},
                      ),
                    ),
                  );
                },
                icon: const Icon(
                  Icons.edit,
                  color: Colors.blue,
                ),
              ),
              IconButton(
                onPressed: () => _confirmDeleteUser(context, user.id),
                icon: const Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _confirmDeleteUser(BuildContext context, String userId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Eliminar Usuario"),
        content:
            const Text("¿Estás seguro de que quieres eliminar este usuario?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancelar"),
          ),
          TextButton(
            onPressed: () {
              onDeleteUser(userId);
              Navigator.pop(context);
            },
            child: const Text("Eliminar", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
