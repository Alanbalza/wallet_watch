import 'package:flutter/material.dart';
import 'package:walletwachs/pages/home_pages.dart';
import 'package:walletwachs/pages/register_pages.dart';
import 'package:walletwachs/pages/login_pages.dart';
import 'package:walletwachs/pages/landing_pages.dart';
import 'package:walletwachs/pages/wallet_pages.dart';
import 'package:walletwachs/pages/movimientos_pages.dart';
import 'package:walletwachs/pages/nuevo_gastos_pages.dart';
import 'package:walletwachs/pages/user_page.dart'; 
import 'package:walletwachs/pages/gastos_pages.dart';// Importa la nueva página

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WalletWatch',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const RegistroUsuario(),
        '/home': (context) => const MyHomePage(),
        '/login': (context) => const InicioSesion(),
        '/landing': (context) => const Landing(),
        '/wallet': (context) => const WalletPage(),
        '/movimientos': (context) => const MovimientosPage(),
        '/nuevo_gasto': (context) => const NuevoGastoPage(),
        '/user': (context) => const UserPage(),
        '/gasto': (context) => const GastoPage(), // Agrega la nueva ruta aquí
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
