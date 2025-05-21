import 'package:flutter/material.dart';
import 'screen/login_screen.dart';
import 'screen/register_screen.dart';
import 'screen/contact_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login App Ucompensar',
      initialRoute: '/',
      routes: {
        '/': (context) => LoginScreen(),
        '/register': (context) => RegisterScreen(),
        '/list': (context) => ContactListScreen(),
        //'/edit': (context) => EditContactScreen(),
      },
    );
  }
}
