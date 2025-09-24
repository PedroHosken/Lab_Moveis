// arquivo: login_page.dart

import 'package:flutter/material.dart';
import 'reg.dart'; // Importa a classe UserData

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Esta é a função que contém a lógica que você pediu.
  void _login() {
    final email = _emailController.text;
    final password = _passwordController.text;
    final name = _nameController.text;

    // AQUI ACONTECE A VALIDAÇÃO
    if (email == 'admin@admin.com' && password == '12345') {
      
      // SE ESTIVER CERTO, ELE ENTRA AQUI E NAVEGA PARA A PÁGINA DE LISTA
      Navigator.pushNamed(
        context,
        '/itemList', // O nome da rota para a página de lista
        arguments: {'name': name.isNotEmpty ? name : 'Admin'},
      );

    } else {
      // Se estiver errado, ele mostra o diálogo de erro.
      _showErrorDialog('Dados inválidos', 'Usuário e/ou senha incorreto(a).');
    }
  }

  void _navigateToRegistration() async {
    final result = await Navigator.pushNamed(context, '/registration');

    if (result != null && result is UserData) {
      setState(() {
        _nameController.text = result.name;
        _emailController.text = result.email;
        _passwordController.text = result.password;
      });
      _showSuccessDialog('Cadastro realizado com sucesso!');
    }
  }
  
  void _showErrorDialog(String title, String content) {
    showDialog(context: context, builder: (context) => AlertDialog(
      title: Text(title), content: Text(content),
      actions: [TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('OK'))],
    ));
  }
  
  void _showSuccessDialog(String message) {
     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(message),
          backgroundColor: Colors.green,
     ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        backgroundColor: Colors.lightGreen,
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          width: 300,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(controller: _nameController, decoration: const InputDecoration(labelText: "Nome")),
              const SizedBox(height: 20),
              TextField(controller: _emailController, keyboardType: TextInputType.emailAddress, decoration: const InputDecoration(labelText: "E-mail")),
              const SizedBox(height: 20),
              TextField(controller: _passwordController, obscureText: true, decoration: const InputDecoration(labelText: "Senha")),
              const SizedBox(height: 30),
              ElevatedButton(
                // O botão "Enter" chama a função _login
                onPressed: _login, 
                child: const Text('Enter')
              ),
              TextButton(
                onPressed: _navigateToRegistration, 
                child: const Text('Crie uma conta'),
              )
            ],
          ),
        ),
      ),
    );
  }
}