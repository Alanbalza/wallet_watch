import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WalletPage extends StatefulWidget {
  const WalletPage({super.key});

  @override
  _WalletPageState createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  List<dynamic> _carteras = [];

  final String _token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2NjlmMzFhNGQ0ZWViZDI3OWE1YmViMTQiLCJpYXQiOjE3MjE3MDg5NjQsImV4cCI6MTcyMTcxMjU2NH0.49ja6bvA-0yieweqKyv3amKdEeJAwRxG5RveOfx9xXE';

  @override
  void initState() {
    super.initState();
    _fetchCarteras();
  }

  Future<void> _fetchCarteras() async {
    final response = await http.get(
      Uri.parse('http://54.204.74.103:3000/api/carteras'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $_token',
      },
    );

    if (response.statusCode == 200) {
      setState(() {
        _carteras = json.decode(response.body);
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al obtener carteras: ${response.body}')),
      );
    }
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
            const Text(
              'Carteras',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const Divider(thickness: 2),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: _carteras.length,
                itemBuilder: (context, index) {
                  final cartera = _carteras[index];
                  return _buildCard(cartera);
                },
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: FloatingActionButton(
                onPressed: () {
                  // Acción al presionar el botón
                },
                backgroundColor: Colors.green,
                child: const Icon(Icons.add),
                
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

  Widget _buildCard(dynamic cartera) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        leading: Icon(Icons.account_balance_wallet),
        title: Text(cartera['nombre']),
        subtitle: Text('Monto: ${cartera['monto']}'),
      ),
    );
  }
}
