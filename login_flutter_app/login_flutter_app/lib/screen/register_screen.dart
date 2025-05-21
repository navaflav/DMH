import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RegisterScreen extends StatelessWidget {
  final TextEditingController userController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final TextEditingController nombreController = TextEditingController();
  final TextEditingController celularController = TextEditingController();
  final TextEditingController correoController = TextEditingController();

  void register(BuildContext context) async {
  final response = await http.post(
    Uri.parse('http://10.0.2.2:5105/api/Contact'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({
      'nombre': nombreController.text,
      'celular': celularController.text,
      'correo': correoController.text,
      'username': userController.text,
      'password': passController.text,
    }),
  );

  if (response.statusCode == 200 || response.statusCode == 201) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Usuario registrado correctamente")),
    );
    Navigator.pop(context);
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Error al registrar usuario")),
    );
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Registro')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(controller: userController, decoration: InputDecoration(labelText: 'Username')),
              TextField(controller: passController, decoration: InputDecoration(labelText: 'Clave'), obscureText: true),
              TextField(controller: nombreController, decoration: InputDecoration(labelText: 'Nombre')),
              TextField(controller: celularController, decoration: InputDecoration(labelText: 'Celular')),
              TextField(controller: correoController, decoration: InputDecoration(labelText: 'Correo')),
              SizedBox(height: 20),
              ElevatedButton(onPressed: () => register(context), child: Text('Registrar')),
            ],
          ),
        ),
      ),
    );
  }
}