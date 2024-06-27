import 'package:flutter/material.dart';

class NuevoGastoPage extends StatelessWidget {
  const NuevoGastoPage({super.key});

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
                Scaffold.of(context).openDrawer();
              },
            ),
          ),
        ],
      ),
      drawer: const Drawer(), // Aquí puedes agregar tu Drawer personalizado
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
            _buildTextField('Monto'),
            const SizedBox(height: 16),
            _buildTextField('Fecha de ingreso'),
            const SizedBox(height: 16),
            _buildDropdown('Categoria'),
            const Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Acción al presionar el botón de enviar
                },
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

  Widget _buildTextField(String label) {
    return TextField(
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
          value: null,
          items: <String>['Categoría 1', 'Categoría 2', 'Categoría 3'].map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (String? newValue) {
            // Acción al seleccionar una nueva categoría
          },
        ),
      ),
    );
  }
}
