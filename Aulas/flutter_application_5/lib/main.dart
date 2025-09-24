import 'package:flutter/material.dart';
import 'login.dart';
import 'item.dart';
import 'reg.dart'; // PASSO 1: Importar o arquivo da tela de cadastro.

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
        // PASSO 2: Adicionar a nova rota nomeada para a tela de cadastro.
        '/reg': (context) => const RegistrationScreen(),
        '/itemList': (context) {
          final args = ModalRoute.of(context)!.settings.arguments as Map<String, String>;
          final name = args['name'] ?? 'Usuário';
          return ItemListPage(name: name);
        },
      },
    );
  }
}