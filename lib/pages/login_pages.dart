import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class InicioSesion extends StatefulWidget {
  const InicioSesion({super.key});

  @override
  _InicioSesionState createState() => _InicioSesionState();
}

class _InicioSesionState extends State<InicioSesion> {
  final _correoController = TextEditingController();
  final _contrasenaController = TextEditingController();

  Future<void> _iniciarSesion() async {
    final response = await http.post(
      Uri.parse('http://54.204.74.103:3000/api/usuarios/login'), // Asegúrate de que la URL sea correcta
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'correo': _correoController.text,
        'contraseña': _contrasenaController.text,
      }),
    );

    if (response.statusCode == 200) {
      // Si el servidor devuelve un código 200 OK, inicia sesión
      Navigator.pushNamed(context, '/landing');
    } else {
      // Si el servidor devuelve un error, muestra un mensaje de error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al iniciar sesión: ${response.body}')),
      );
    }
  }

  @override
  void dispose() {
    _correoController.dispose();
    _contrasenaController.dispose();
    super.dispose();
  }

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
                'Inicio de Sesion',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            const Divider(thickness: 2),
            const SizedBox(height: 16),
            _buildTextField(_correoController, 'Correo'),
            const SizedBox(height: 16),
            _buildTextField(_contrasenaController, 'Contraseña', isPassword: true),
            const SizedBox(height: 32),
            Center(
              child: Image.asset('assets/Frame.png', height: 150), // Asegúrate de tener la imagen en assets
            ),
            const SizedBox(height: 32),
            Center(
              child: ElevatedButton(
                onPressed: _iniciarSesion,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                ),
                child: const Text('Iniciar Sesión'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, {bool isPassword = false}) {
    return TextField(
      controller: controller,
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
