
import 'package:flutter/material.dart';
import 'login_page.dart';        
import 'item_list_page.dart';     
import 'registration_page.dart';  

void main() {
  runApp(const Home());
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login App',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const Login(),
        // A rota para o registro agora é '/registration' para consistência
        '/registration': (context) => const RegistrationScreen(),
        '/itemList': (context) {
          final args = ModalRoute.of(context)!.settings.arguments as Map<String, String>;
          final name = args['name'] ?? 'Usuário';
          return ItemListPage(name: name);
        },
      },
    );
  }
}