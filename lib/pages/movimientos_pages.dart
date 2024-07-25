import 'package:flutter/material.dart';

class MovimientosPage extends StatelessWidget {
  const MovimientosPage({super.key});

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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Movimientos',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const Divider(thickness: 2),
            const SizedBox(height: 16),
            _buildGrafica('gastos por cartera', 'assets/Bar.png'),
            const SizedBox(height: 16),
            _buildGrafica('gasto del dia', 'assets/Bar1.png'),
            const SizedBox(height: 16),
            const Text(
              'Tu ultima actividad',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildActividad('ingreso:'),
            const SizedBox(height: 16),
            _buildActividad('compro:'),
            const SizedBox(height: 16),
            _buildActividad('gasto en:'),
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

  Widget _buildGrafica(String titulo, String asset) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          titulo,
          style: const TextStyle(fontSize: 18),
        ),
        const SizedBox(height: 8),
        Image.asset(
          asset,
          height: 150,
          width: double.infinity,
          fit: BoxFit.cover,
          errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
            return const Text('Error loading image');
          },
        ),
      ],
    );
  }

  Widget _buildActividad(String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Colors.green[100],
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.all(8),
          child: const Text(''),
        ),
      ],
    );
  }
}
