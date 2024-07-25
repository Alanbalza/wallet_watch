import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GastoPage extends StatefulWidget {
  const GastoPage({super.key});

  @override
  _GastoPageState createState() => _GastoPageState();
}

class _GastoPageState extends State<GastoPage> {
  List<dynamic> _gastos = [];
  final String _token = 'tu_token_aqui';

  @override
  void initState() {
    super.initState();
    _fetchGastos();
  }

  Future<void> _fetchGastos() async {
    final response = await http.get(
      Uri.parse('http://54.204.74.103:3000/api/gastos'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $_token',
      },
    );

    if (response.statusCode == 200) {
      setState(() {
        _gastos = json.decode(response.body);
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al obtener gastos: ${response.body}')),
      );
    }
  }

  Future<void> _deleteGasto(String id) async {
    final response = await http.delete(
      Uri.parse('http://54.204.74.103:3000/api/gastos/668d7b94004cf4a5446c6268'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $_token',
      },
    );

    if (response.statusCode == 200 || response.statusCode == 204) {
      setState(() {
        _gastos.removeWhere((gasto) => gasto['id'] == id);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gasto eliminado con éxito')),
      );
    } else {
      print('Error: ${response.statusCode} - ${response.body}');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al eliminar gasto: ${response.body}')),
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
            const Text('GastoWatch'),
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
                  'GastoWatch',
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
                },
              ),
              _createDrawerItem(
                icon: Icons.add,
                text: 'Registrar gasto',
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/home');
                },
              ),
              _createDrawerItem(
                icon: Icons.add,
                text: 'Nuevo gasto',
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/nuevo_gasto');
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
              'Gastos',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const Divider(thickness: 2),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: _gastos.length,
                itemBuilder: (context, index) {
                  final gasto = _gastos[index];
                  return _buildCard(gasto);
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

  Widget _buildCard(dynamic gasto) {
    final id = gasto['id'] ?? '';
    final nombre = gasto['nombre'] ?? 'Sin nombre';
    final monto = gasto['monto'] ?? 0;

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        leading: Icon(Icons.monetization_on),
        title: Text(nombre),
        subtitle: Text('Monto: $monto'),
        trailing: IconButton(
          icon: Icon(Icons.delete, color: Colors.red),
          onPressed: id.isNotEmpty ? () => _confirmDelete(id) : null,
        ),
      ),
    );
  }

  void _confirmDelete(String id) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Confirmar eliminación'),
        content: Text('¿Estás seguro de que deseas eliminar este gasto?'),
        actions: <Widget>[
          TextButton(
            child: Text('Cancelar'),
            onPressed: () => Navigator.of(context).pop(),
          ),
          TextButton(
            child: Text('Eliminar'),
            onPressed: () {
              Navigator.of(context).pop();
              _deleteGasto(id);
            },
          ),
        ],
      ),
    );
  }
}
