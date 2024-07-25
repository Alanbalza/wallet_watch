import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Landing extends StatelessWidget {
  const Landing({super.key});

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      final bool launched = await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
      if (!launched) {
        throw 'Could not launch $url';
      }
    } else {
      throw 'Could not launch $url';
    }
  }

  Widget _buildSocialIcon(String assetPath, String url) {
    return GestureDetector(
      onTap: () => _launchURL(url),
      child: Image.asset(assetPath, height: 40, width: 40),
    );
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
              const DrawerHeader(
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
              _createDrawerItem(
                icon: Icons.add,
                text: 'Nuevo gasto',
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/nuevo_gasto');
                  // Añade la acción que deseas realizar
                },
              ),
              _createDrawerItem(
              icon: Icons.add, 
              text: 'Gastos', 
              onTap: (){
                Navigator.pop(context);
                 Navigator.pushNamed(context, '/gasto');
              }
              ),
               _createDrawerItem(
              icon: Icons.add, 
              text: 'Usuario', 
              onTap: (){
                Navigator.pop(context);
                 Navigator.pushNamed(context, '/user');
              }
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
            _buildSaldoDisponible(),
            const SizedBox(height: 16),
            _buildGraficaGeneral(),
            const SizedBox(height: 16),
            _buildGraficaPorDia(),
            const SizedBox(height: 16),
            _buildUltimaActividad(),
            const SizedBox(height: 16),
            _buildConocenosEn(),
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
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          onTap: onTap,
        ),
      ),
    );
  }

  Widget _buildSaldoDisponible() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Disponible',
          style: TextStyle(fontSize: 20),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Text(
            '\$2000',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      ],
    );
  }

  Widget _buildGraficaGeneral() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Grafica General de gastos',
          style: TextStyle(fontSize: 18, backgroundColor: Colors.yellow),
        ),
        const SizedBox(height: 8),
        Image.asset('assets/Bar.png', height: 150),
      ],
    );
  }

  Widget _buildGraficaPorDia() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Grafica por dia',
          style: TextStyle(fontSize: 18, backgroundColor: Colors.yellow),
        ),
        const SizedBox(height: 8),
        Image.asset('assets/Bar1.png', height: 150),
      ],
    );
  }

  Widget _buildUltimaActividad() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Tu ultima actividad',
              style: TextStyle(fontSize: 18),
            ),
            TextButton(
              onPressed: () {},
              child: const Text('Ver mas'),
            ),
          ],
        ),
        _buildActividad('Compro comida:  \$120', 'Fecha: 12/12/24'),
        _buildActividad('Gasto en transporte: \$10', 'Fecha: 12/12/24'),
        _buildActividad('Ingreso: \$2000', 'Fecha: 12/12/24'),
      ],
    );
  }

  Widget _buildActividad(String actividad, String fecha) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.green[100],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            actividad,
            style: const TextStyle(fontSize: 16),
          ),
          Text(fecha),
        ],
      ),
    );
  }

  Widget _buildConocenosEn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Conocenos en',
          style: TextStyle(fontSize: 18),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildSocialIcon('assets/facebook.png', 'https://www.facebook.com'),
            _buildSocialIcon('assets/twitter.png', 'https://www.twitter.com'),
            _buildSocialIcon('assets/whatsapp.png', 'https://www.whatsapp.com'),
            _buildSocialIcon('assets/instagram.png', 'https://www.instagram.com'),
          ],
        ),
      ],
    );
  }
}
