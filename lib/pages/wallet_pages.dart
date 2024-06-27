import 'package:flutter/material.dart';

class WalletPage extends StatelessWidget {
  const WalletPage({super.key});

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
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ],
      ),
       // Aquí puedes agregar tu Drawer personalizado
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
            _buildCard('assets/bbva.png'),
            const SizedBox(height: 16),
            _buildCard('assets/spin.png'),
            const SizedBox(height: 16),
            _buildCard('assets/mercado.png'),
            const Spacer(),
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

  Widget _buildCard(String asset) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Image.asset(
        asset,
        height: 100,
        width: double.infinity,
        fit: BoxFit.cover,
      ),
    );
  }
}
