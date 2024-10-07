import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Temporizador para navegar automáticamente a la página principal después de 3 segundos
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.of(context).pushReplacementNamed('/home');
    });

    return Scaffold(
      backgroundColor: Colors.black, // Color de fondo del splash screen
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Reemplaza el CircularProgressIndicator con tu imagen
            Image.asset('assets/images/logo.png',
                width: 195), // Ajusta la ruta y el tamaño según necesites
            const SizedBox(height: 120),
            const Text('APP DE ARTE LOCAL...'), // Mensaje opcional
          ],
        ),
      ),
    );
  }
}
