import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'welcome_screen.dart';
import 'contact_list_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final TextEditingController userController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  void login(BuildContext context) async {
    final username = userController.text;
    final password = passController.text;

    final url = Uri.parse('http://10.0.2.2:5105/api/Contact/login');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'username': username, 'password': password}),
      );

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        final nombre = json['nombre'] ?? 'Estudiante';

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => WelcomeScreen(nombre: nombre)),
        );
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Credenciales inválidas")));
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error de conexión: \$e")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: userController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: passController,
              decoration: InputDecoration(labelText: 'Clave'),
              obscureText: true,
            ),
            ElevatedButton(
              onPressed: () => login(context),
              child: Text('Ingresar'),
            ),
            TextButton(
              child: Text('Registrarse'),
              onPressed: () {
                Navigator.pushNamed(context, '/register');
              },
            ),
          ],
        ),
      ),
    );
  }
}
