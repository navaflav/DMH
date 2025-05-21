import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Contact {
  final int id;
  final String nombre;
  final String celular;
  final String correo;
  final String username;

  Contact({
    required this.id,
    required this.nombre,
    required this.celular,
    required this.correo,
    required this.username,
  });

  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(
      id: json['id'],
      nombre: json['nombre'],
      celular: json['celular'],
      correo: json['correo'],
      username: json['username'],
    );
  }
}

class ContactListScreen extends StatefulWidget {
  const ContactListScreen({super.key});

  @override
  _ContactListScreenState createState() => _ContactListScreenState();
}

class _ContactListScreenState extends State<ContactListScreen> {
  List<Contact> contacts = [];

  Future<void> fetchContacts() async {
    final response = await http.get(
      Uri.parse('http://10.0.2.2:5105/api/Contact'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      setState(() {
        contacts = data.map((json) => Contact.fromJson(json)).toList();
      });
    }
  }

  Future<void> deleteContact(int id) async {
    final response = await http.delete(
      Uri.parse('http://10.0.2.2:5105/api/Contact/$id'),
    );
    if (response.statusCode == 204) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Contacto eliminado')));
      fetchContacts();
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error al eliminar')));
    }
  }

  @override
  void initState() {
    super.initState();
    fetchContacts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Lista de Usuarios')),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: const [
            DataColumn(label: Text('Nombre')),
            DataColumn(label: Text('Celular')),
            DataColumn(label: Text('Correo')),
            DataColumn(label: Text('Usuario')),
            DataColumn(label: Text('Acciones')),
          ],
          rows:
              contacts.map((Contact) {
                return DataRow(
                  cells: [
                    DataCell(Text(Contact.nombre)),
                    DataCell(Text(Contact.celular)),
                    DataCell(Text(Contact.correo)),
                    DataCell(Text(Contact.username)),
                    DataCell(
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit, color: Colors.orange),
                            onPressed: () {
                              Navigator.popAndPushNamed(
                                context,
                                '/edit',
                                arguments: Contact,
                              );
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              deleteContact(Contact.id);
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }).toList(),
        ),
      ),
    );
  }
}
