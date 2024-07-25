import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  Map<String, String> _userData = {};

  final String _token = 'tu_token_aqui';

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    try {
      final response = await http.get(
        Uri.parse('http://54.204.74.103:3000/api/usuarios/669f27c7d4eebd279a5beb02'), // Reemplaza con tu URL de API
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $_token',
        },
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body);

        if (data != null && data is Map) {
          setState(() {
            _userData = data.map((key, value) => MapEntry(key, value?.toString() ?? 'N/A'));
          });
        } else {
          throw Exception('Formato de datos incorrecto');
        }
      } else {
        throw Exception('Error al obtener datos del usuario: ${response.body}');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  Future<void> _updateUserData(String key, String newValue) async {
    try {
      // Crea una copia local de _userData
      Map<String, String> updatedUserData = Map.from(_userData);

      // Actualiza solo el campo que se está modificando
      updatedUserData[key] = newValue;

      // Remueve campos no editables como _id y __v
      updatedUserData.remove('_id');
      updatedUserData.remove('__v'); // Si es necesario, remueve otros campos no editables

      // Luego envía todos los datos actualizados a la API, excepto los campos no editables
      final response = await http.put(
        Uri.parse('http://54.204.74.103:3000/api/usuarios/669f27c7d4eebd279a5beb02'), // Reemplaza con tu URL de API
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $_token',
        },
        body: json.encode(updatedUserData),
      );

      if (response.statusCode == 200) {
        setState(() {
          _userData[key] = newValue;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Datos actualizados exitosamente')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al actualizar datos: ${response.body}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Row(
          children: [
            Image.asset('assets/LOGO.png', height: 40), // Asegúrate de tener el logo en assets
            const SizedBox(width: 10),
            const Text('User Profile'),
          ],
        ),
        actions: [
          Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openEndDrawer();
              },
            ),
          ),
        ],
      ),
      endDrawer: Drawer(
        child: Container(
          color: Colors.blue,
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Text(
                  'User Profile',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
              _createDrawerItem(
                icon: Icons.person,
                text: 'Perfil',
                onTap: () {
                  Navigator.pop(context);
                  // Añade la acción que deseas realizar
                },
              ),
              _createDrawerItem(
                icon: Icons.settings,
                text: 'Configuración',
                onTap: () {
                  Navigator.pop(context);
                  // Añade la acción que deseas realizar
                },
              ),
              _createDrawerItem(
                icon: Icons.logout,
                text: 'Cerrar sesión',
                onTap: () {
                  Navigator.pop(context);
                  // Añade la acción que deseas realizar
                },
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Datos del Usuario',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const Divider(thickness: 2),
            const SizedBox(height: 16),
            _userData.isNotEmpty
                ? _buildUserDataCard()
                : Center(child: CircularProgressIndicator()),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _createDrawerItem({
    required IconData icon,
    required String text,
    required GestureTapCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.black),
      title: Text(
        text,
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: onTap,
    );
  }

  Widget _buildUserDataCard() {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: _userData.entries.map((entry) {
            return _buildUserInfoRow(entry.key, entry.value);
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildUserInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          Row(
            children: [
              Text(
                value,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  _showEditDialog(label, value);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showEditDialog(String field, String currentValue) {
    TextEditingController controller = TextEditingController(text: currentValue);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Editar $field'),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(
              labelText: field,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                _updateUserData(field, controller.text);
                Navigator.of(context).pop();
              },
              child: Text('Guardar'),
            ),
          ],
        );
      },
    );
  }
}
