
import 'package:flutter/material.dart';
import 'registration_page.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _login() {
    final email = _emailController.text;
    final password = _passwordController.text;
    final name = _nameController.text;

    if (email == 'admin@admin.com' && password == '12345') {
      Navigator.pushNamed(
        context,
        '/itemList',
        arguments: {'name': name.isNotEmpty ? name : 'Admin'},
      );
    } else {
      _showErrorDialog('Dados inválidos', 'Usuário e/ou senha incorreto(a).');
    }
  }

  void _navigateToRegistration() async {
    // CORRIGIDO: Chamando a rota '/registration' definida no main.dart
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
        child: SingleChildScrollView( // Adicionado para evitar overflow em telas pequenas
          padding: const EdgeInsets.all(16.0),
          child: SizedBox(
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
      ),
    );
  }
}