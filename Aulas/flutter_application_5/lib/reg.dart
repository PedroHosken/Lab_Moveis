import 'package:flutter/material.dart';

// PASSO 1: Criar uma classe para organizar os dados do usuário.
// Isso torna o código mais limpo do que passar vários valores soltos.
class UserData {
  final String name;
  final String email;
  final String password;

  UserData({required this.name, required this.email, required this.password});
}

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _birthDateController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordObscured = true;
  String? _gender;
  bool _emailNotifications = true;
  bool _phoneNotifications = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create an account'), centerTitle: true),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          TextField(
            controller: _nameController,
            maxLength: 50,
            keyboardType: TextInputType.name,
            decoration: const InputDecoration(
              labelText: 'Nome',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          // ... (outros TextFields como no seu código)
          TextField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              labelText: 'E-mail',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _passwordController,
            maxLength: 20,
            obscureText: _isPasswordObscured,
            decoration: InputDecoration(
              labelText: 'Senha',
              border: const OutlineInputBorder(),
              suffixIcon: IconButton(
                icon: Icon(
                  _isPasswordObscured ? Icons.visibility_off : Icons.visibility,
                ),
                onPressed: () {
                  setState(() {
                    _isPasswordObscured = !_isPasswordObscured;
                  });
                },
              ),
            ),
          ),
          const SizedBox(height: 24),
          // ... (outros widgets de Gênero e Notificações)
          const SizedBox(height: 32),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              textStyle: const TextStyle(fontSize: 18),
            ),
            onPressed: () {
              // PASSO 2: Ao pressionar o botão, criamos um objeto com os dados dos controllers.
              final userData = UserData(
                name: _nameController.text,
                email: _emailController.text,
                password: _passwordController.text,
              );

              // Usamos Navigator.pop para fechar a tela e ENVIAR o objeto 'userData' de volta.
              Navigator.pop(context, userData);
            },
            child: const Text('Cadastrar'),
          ),
        ],
      ),
    );
  }
}
