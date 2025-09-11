import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Remove a faixa de "Debug" no canto da tela
      debugShowCheckedModeBanner: false,
      title: 'Tela de Cadastro',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        // Define um tema visual mais moderno para os componentes
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const RegistrationScreen(),
    );
  }
}

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  // --- CONTROLLERS PARA OS CAMPOS DE TEXTO ---
  // Controllers são usados para ler e controlar o texto dos TextFields. [cite: 414]
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _birthDateController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // --- VARIÁVEIS DE ESTADO ---
  // Variável para controlar a visibilidade da senha.
  bool _isPasswordObscured = true;

  // Variável para controlar a seleção de gênero. Usamos String para o valor do Radio.
  String? _gender; // Pode ser 'masculino' ou 'feminino'

  // Variáveis para controlar os switches de notificação.
  bool _emailNotifications = true;
  bool _phoneNotifications = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create an account'), centerTitle: true),
      // Usamos um ListView para que a tela seja rolável se o conteúdo for maior que a tela.
      body: ListView(
        // Adicionamos um padding para dar um respiro nas bordas da tela.
        padding: const EdgeInsets.all(16.0),
        children: [
          // --- CAMPO NOME ---
          TextField(
            controller: _nameController,
            maxLength: 50, // Limitação de caracteres. [cite: 1014]
            keyboardType: TextInputType
                .name, // Teclado apropriado para nomes. [cite: 1015]
            decoration: const InputDecoration(
              labelText: 'Nome',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16), // Espaçamento entre os campos
          // --- CAMPO DATA DE NASCIMENTO ---
          TextField(
            controller: _birthDateController,
            maxLength: 10,
            keyboardType: TextInputType
                .datetime, // Teclado apropriado para data. [cite: 1015, 332]
            decoration: const InputDecoration(
              labelText: 'Data de nascimento',
              hintText: 'DD/MM/AAAA',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),

          // --- CAMPO TELEFONE ---
          TextField(
            controller: _phoneController,
            maxLength: 15, // Limitação de caracteres. [cite: 1014]
            keyboardType: TextInputType
                .phone, // Teclado apropriado para telefone. [cite: 1015]
            decoration: const InputDecoration(
              labelText: 'Telefone',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),

          // --- CAMPO E-MAIL ---
          TextField(
            controller: _emailController,
            keyboardType: TextInputType
                .emailAddress, // Teclado apropriado para e-mail. [cite: 1015]
            decoration: const InputDecoration(
              labelText: 'E-mail',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),

          // --- CAMPO SENHA ---
          TextField(
            controller: _passwordController,
            maxLength: 20, // Limitação de caracteres. [cite: 1014]
            obscureText:
                _isPasswordObscured, // Usa a variável de estado para esconder/mostrar o texto. [cite: 345]
            decoration: InputDecoration(
              labelText: 'Senha',
              border: const OutlineInputBorder(),
              // Ícone para alterar a visibilidade da senha. [cite: 1018]
              suffixIcon: IconButton(
                icon: Icon(
                  // Muda o ícone baseado no estado da visibilidade.
                  _isPasswordObscured ? Icons.visibility_off : Icons.visibility,
                ),
                onPressed: () {
                  // setState é chamado para reconstruir a tela com o novo estado. [cite: 101]
                  setState(() {
                    _isPasswordObscured = !_isPasswordObscured;
                  });
                },
              ),
            ),
          ),
          const SizedBox(height: 24),

          // --- SELEÇÃO DE GÊNERO ---
          const Text('Gênero:', style: TextStyle(fontSize: 16)),
          // Usamos RadioListTile para criar opções de seleção única. [cite: 760]
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Adicionamos um Expanded para que o RadioListTile não cause overflow na Row. [cite: 1034]
              Expanded(
                child: RadioListTile<String>(
                  title: const Text('Masculino'),
                  value: 'masculino',
                  groupValue:
                      _gender, // Controla qual item do grupo está selecionado. [cite: 685]
                  onChanged: (value) {
                    setState(() {
                      _gender = value;
                    });
                  },
                ),
              ),
              Expanded(
                child: RadioListTile<String>(
                  title: const Text('Feminino'),
                  value: 'feminino',
                  groupValue: _gender,
                  onChanged: (value) {
                    setState(() {
                      // Atualiza o estado para refletir a nova seleção. [cite: 718]
                      _gender = value;
                    });
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // --- OPÇÕES DE NOTIFICAÇÃO ---
          const Text('Notificações:', style: TextStyle(fontSize: 16)),
          // SwitchListTile é um componente pronto que combina texto e um Switch.
          SwitchListTile(
            title: const Text('Receber notificações por E-mail'),
            value: _emailNotifications,
            onChanged: (value) {
              setState(() {
                _emailNotifications = value;
              });
            },
          ),
          SwitchListTile(
            title: const Text('Receber notificações por Celular'),
            value: _phoneNotifications,
            onChanged: (value) {
              // A função onChanged é chamada quando o switch muda de estado. [cite: 843]
              setState(() {
                // E o setState atualiza a interface. [cite: 862]
                _phoneNotifications = value;
              });
            },
          ),
          const SizedBox(height: 32),

          // --- BOTÃO CADASTRAR ---
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              textStyle: const TextStyle(fontSize: 18),
            ),
            onPressed: () {
              // Aqui você pode adicionar a lógica para salvar os dados.
              // Por enquanto, vamos apenas mostrar no console.
              print('Nome: ${_nameController.text}');
              print('Data de Nascimento: ${_birthDateController.text}');
              print('Telefone: ${_phoneController.text}');
              print('E-mail: ${_emailController.text}');
              print('Senha: ${_passwordController.text}');
              print('Gênero: $_gender');
              print('Notificações por E-mail: $_emailNotifications');
              print('Notificações por Celular: $_phoneNotifications');
            },
            child: const Text('Cadastrar'), // Botão de cadastro. [cite: 1023]
          ),
        ],
      ),
    );
  }
}
