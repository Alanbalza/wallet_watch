import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {},
          ),
        ],
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
            _build3DTextField('Nombre de la tarjeta'),
            const SizedBox(height: 16),
            _build3DTextField('Monto'),
            const SizedBox(height: 16),
            _build3DTextField('Fecha de ingreso'),
            const SizedBox(height: 32),
            Center(
              child: _build3DButton(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _build3DTextField(String labelText) {
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
        onPressed: () {
          Navigator.pop(context);
        },
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
