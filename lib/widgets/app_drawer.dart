// lib/widgets/app_drawer.dart
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xFFF5F5F5),
      child: ListView(
        children: [
          SizedBox(
            width: double.infinity,
            child: DrawerHeader(
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 30,
                    child: Icon(Icons.person),
                  ),
                  const SizedBox(height: 10, width: 30),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text("Usuario",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                      Text("Editar perfil",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueAccent)),
                    ],
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            title: const Text(
              "Perfiles",
              style: TextStyle(
                  fontSize: 15, fontWeight: FontWeight.w300, height: 3),
            ),
            subtitle: Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.green[400],
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
                const SizedBox(width: 12),
                const Text(
                  "Añadir perfil",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          const Divider(
            height: 25,
            thickness: 1,
          ),
          ListTile(
            title: Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.blueAccent[400],
                  child: const Icon(
                    Icons.logout,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
                const SizedBox(width: 12),
                const Text(
                  "Cerrar sesión",
                  style: TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w400, height: 3),
                ),
              ],
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
