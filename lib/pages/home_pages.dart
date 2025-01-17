import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _nombreController = TextEditingController();
  final _montoController = TextEditingController();
  final _fechaController = TextEditingController();

  Future<void> _registrarCartera() async {
    final response = await http.post(
      Uri.parse('http://54.204.74.103:3000/api/carteras'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'nombre': _nombreController.text,
        'monto': _montoController.text,
        'fecha': _fechaController.text,
      }),
    );

    if (response.statusCode == 201) {
      // Si el servidor devuelve un código 201 CREATED, muestra un mensaje de éxito
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Cartera registrada con éxito')),
      );
    } else {
      // Si el servidor devuelve un error, muestra un mensaje de error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al registrar cartera: ${response.body}')),
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
        leading: IconButton(
          icon: const Icon(Icons.account_balance_wallet),
          onPressed: () {},
        ),
        title: const Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Text('WalletWatch'),
            ),
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
                text: 'Nuevo gasto',
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/nuevo_gasto');
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
            const Center(
              child: Text(
                'Registrar nueva cartera',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Divider(thickness: 2),
            const SizedBox(height: 16),
            _build3DTextField(_nombreController, 'Nombre de la tarjeta'),
            const SizedBox(height: 16),
            _build3DTextField(_montoController, 'Monto'),
            const SizedBox(height: 16),
            _build3DTextField(_fechaController, 'Fecha de ingreso'),
            const SizedBox(height: 32),
            Center(
              child: _build3DButton(),
            ),
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

  Widget _build3DTextField(TextEditingController controller, String labelText) {
    return Container(
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            offset: Offset(2, 2),
            blurRadius: 4,
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(10),
          ),
          labelText: labelText,
          filled: true,
          fillColor: const Color.fromARGB(255, 66, 202, 118),
        ),
      ),
    );
  }

  Widget _build3DButton() {
    return Container(
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            offset: Offset(2, 2),
            blurRadius: 4,
          ),
        ],
        borderRadius: BorderRadius.circular(10),
      ),
      child: ElevatedButton(
        onPressed: _registrarCartera,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
        ),
        child: const Text('Registrar', style: TextStyle(fontSize: 16)),
      ),
    );
  }
}
