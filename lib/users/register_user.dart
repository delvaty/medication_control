import 'package:flutter/material.dart';

class RegistroPerfilScreen extends StatefulWidget {
  const RegistroPerfilScreen({super.key});

  @override
  State<RegistroPerfilScreen> createState() => _RegistroPerfilScreenState();
}

class _RegistroPerfilScreenState extends State<RegistroPerfilScreen> {
  String? selectedSex;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController lastnameController = TextEditingController();

  final List<String> sexOptions = [
    'Hombre',
    'Mujer',
    'No binario',
    'Prefiero no decirlo'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[800],
      body: Column(
        children: [
          // Parte superior con botones "Guardar" y "Agregar usuario"
          SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      // Funcionalidad para guardar
                    },
                    child: Text(
                      'Guardar',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const Text(
                    'Agregar usuario',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Espacio entre la barra superior y el contenido principal
          const SizedBox(height: 20),

          // Contenido principal con bordes redondeados
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      const Text(
                        'Información Personal',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 30),

                      // Campo Nombre
                      const Text(
                        'Nombre',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: nameController,
                        decoration: InputDecoration(
                          hintText: 'Ingresa tu nombre',
                          fillColor: Colors.grey[100],
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 16,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Campo Apellidos
                      const Text(
                        'Apellidos',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: lastnameController,
                        decoration: InputDecoration(
                          hintText: 'Ingresa tus apellidos',
                          fillColor: Colors.grey[100],
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 16,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Campo Sexo (Radio buttons)
                      const Text(
                        'Sexo',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Opciones de sexo
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          children: sexOptions.map((opcion) {
                            return RadioListTile<String>(
                              title: Text(opcion),
                              value: opcion,
                              groupValue: selectedSex,
                              onChanged: (value) {
                                setState(() {
                                  selectedSex = value;
                                });
                              },
                              contentPadding: EdgeInsets.zero,
                              dense: true,
                            );
                          }).toList(),
                        ),
                      ),

                      const SizedBox(height: 40),

                      // Botón de Registrarse
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            // Lógica para el registro
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            'Registrarse',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    lastnameController.dispose();
    super.dispose();
  }
}
