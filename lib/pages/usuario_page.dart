import 'package:flutter/material.dart';

class UsuarioPage extends StatelessWidget {
  const UsuarioPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Row(
          children: [
            Image.asset('assets/logo.png', height: 40,
              errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                return Text('Error loading logo');
              },
            ), // Asegúrate de tener el logo en assets
            SizedBox(width: 10),
            Text('WalletWatch'),
          ],
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          Builder(
            builder: (context) => IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            ),
          ),
        ],
      ),
      drawer: Drawer(), // Aquí puedes agregar tu Drawer personalizado
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Datos del Usuario',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Divider(thickness: 2),
            SizedBox(height: 16),
            _buildUserInfo('Nombre', 'Juan Pérez'),
            SizedBox(height: 16),
            _buildUserInfo('Apellido', 'García'),
            SizedBox(height: 16),
            _buildUserInfo('Correo', 'juan@example.com'),
            SizedBox(height: 16),
            _buildUserInfo('Contraseña', '********'),
            SizedBox(height: 16),
            _buildUserInfo('Número de Teléfono', '+123456789'),
            Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Acción al presionar el botón de editar
                  Navigator.pushNamed(context, '/editar_usuario');
                },
                child: Text('Editar Datos'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                ),
              ),
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildUserInfo(String label, String info) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Colors.green[100],
            borderRadius: BorderRadius.circular(10),
          ),
          padding: EdgeInsets.all(8),
          child: Text(info, style: TextStyle(fontSize: 16)),
        ),
      ],
    );
  }
}
