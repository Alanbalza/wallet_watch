import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NuevoGastoPage extends StatefulWidget {
  const NuevoGastoPage({super.key});

  @override
  _NuevoGastoPageState createState() => _NuevoGastoPageState();
}

class _NuevoGastoPageState extends State<NuevoGastoPage> {
  final _nombreController = TextEditingController();
  final _montoController = TextEditingController();
  final _fechaController = TextEditingController();
  String? _categoriaSeleccionada;
  final List<String> _categorias = ['Comida', 'Golosina', 'Bebida'];

  Future<void> _registrarGasto() async {
    final response = await http.post(
      Uri.parse('http://54.204.74.103:3000/api/gastos'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'nombre': _nombreController.text,
        'monto': int.tryParse(_montoController.text) ?? 0,
        'fecha': _fechaController.text,
        'categoria': _categoriaSeleccionada ?? '',
      }),
    );

    if (response.statusCode == 201) {
      // Si el servidor devuelve un código 201 CREATED, muestra un mensaje de éxito
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gasto registrado con éxito')),
      );
    } else {
      // Si el servidor devuelve un error, muestra un mensaje de error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al registrar gasto: ${response.body}')),
      );
    }
  }

  @override
  void dispose() {
    _nombreController.dispose();
    _montoController.dispose();
    _fechaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Row(
          children: [
            Image.asset('assets/LOGO.png', height: 40,
              errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                return const Text('Error loading logo');
              },
            ), // Asegúrate de tener el logo en assets
            const SizedBox(width: 10),
            const Text('WalletWatch'),
          ],
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
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
          color: Colors.green,
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.green,
                ),
                child: Text(
                  'WalletWatch',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                  ),
                ),
              ),
              _createDrawerItem(
                icon: Icons.account_balance_wallet,
                text: 'Carteras',
                onTap: () {
                  Navigator.pop(context);
                   Navigator.pushNamed(context, '/wallet');
                  // Añade la acción que deseas realizar
                },
              ),
              _createDrawerItem(
                icon: Icons.swap_horiz,
                text: 'Movimientos',
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/movimientos');
                  // Añade la acción que deseas realizar
                },
              ),
              _createDrawerItem(
                icon: Icons.add,
                text: 'Registrar cartera',
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/home');
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
              'Nuevo gasto',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const Divider(thickness: 2),
            const SizedBox(height: 16),
            _buildTextField(_nombreController, 'Nombre de la tarjeta'),
            const SizedBox(height: 16),
            _buildTextField(_montoController, 'Monto'),
            const SizedBox(height: 16),
            _buildTextField(_fechaController, 'Fecha de ingreso'),
            const SizedBox(height: 16),
            _buildDropdown('Categoría'),
            const Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: _registrarGasto,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                ),
                child: const Text('Enviar'),
              ),
            ),
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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        color: Colors.lime,
        child: ListTile(
          leading: Icon(icon, color: Colors.black),
          title: Text(
            text,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          onTap: onTap,
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label) {
    return TextField(
      controller: controller,
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

  Widget _buildDropdown(String label) {
    return InputDecorator(
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Colors.green[100],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _categoriaSeleccionada,
          items: _categorias.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              _categoriaSeleccionada = newValue;
            });
          },
        ),
      ),
    );
  }
}
