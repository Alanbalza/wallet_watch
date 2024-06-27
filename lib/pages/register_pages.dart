import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: RegistroUsuario(),
    );
  }
}

class RegistroUsuario extends StatelessWidget {
  const RegistroUsuario({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Row(
          children: [
            Image.asset('assets/LOGO.png', height: 40), // Asegúrate de tener el logo en assets
            const SizedBox(width: 10),
            const Text('WalletWatch'),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Text(
                'Registro de Usuario',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            const Divider(thickness: 2),
            const SizedBox(height: 16),
            _buildTextField('Nombre'),
            const SizedBox(height: 16),
            _buildTextField('Apellido paterno'),
            const SizedBox(height: 16),
            _buildTextField('Telefono'),
            const SizedBox(height: 16),
            _buildTextField('Correo'),
            const SizedBox(height: 16),
            _buildTextField('Contraseña', isPassword: true),
            const SizedBox(height: 32),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Lógica de registro (puede incluir validaciones y envío de datos)
                  // Luego de completar el registro, redirige a la pantalla de inicio de sesión
                  Navigator.pushNamed(context, '/login');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                ),
                child: const Text('Registrar'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, {bool isPassword = false}) {
    return TextField(
      obscureText: isPassword,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Colors.green[100],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
