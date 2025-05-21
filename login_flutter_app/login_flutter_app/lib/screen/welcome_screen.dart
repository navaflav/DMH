import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  final String nombre;

  const WelcomeScreen({super.key, required this.nombre});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Bienvenido(a)')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/Ucompensar.jpg', height: 150),
              SizedBox(height: 30),
              Text(
                'Bienvenido estudiante $nombre, a',
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
              Text(
                'Fundación Universitaria Compensar',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepOrange,
                ),
                textAlign: TextAlign.center,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/list');
                },
                child: Text('Ver Usuarios'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
