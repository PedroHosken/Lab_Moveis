import 'package:flutter/material.dart';

// --- PONTO DE ENTRADA DO APLICATIVO ---
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'App com Navegação',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        // Usamos um tema mais moderno para os campos de texto
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(),
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
        // Estilo para os botões de texto
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: Colors.blue,
          ),
        ),
      ),
      // A tela inicial do nosso app será a MainPage, que controla a navegação.
      home: const MainPage(),
    );
  }
}

// --- TELA PRINCIPAL COM A BARRA DE NAVEGAÇÃO ---
class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  // Variável que controla o índice da aba ativa. Começa em 0 (primeira aba). [cite: 1378]
  int _currentIndex = 0;

  // Lista de widgets (telas) que serão exibidos pela BottomNavigationBar.
  final List<Widget> _pages = [
    const LoginScreen(),
    const AboutPage(),
  ];

  @override
  Widget build(BuildContext context) {
    // A aplicação terá um único Scaffold, gerenciado pela MainPage. [cite: 1354]
    return Scaffold(
      appBar: AppBar(
        // O título da AppBar muda de acordo com a aba selecionada.
        title: Text(_currentIndex == 0 ? 'Login' : 'Sobre'),
        centerTitle: true,
      ),
      // O corpo da tela usa IndexedStack para alternar entre as páginas sem perdê-las. 
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex, // Informa qual item está ativo. [cite: 1376]
        // onTap é chamado quando um item é clicado. [cite: 1388]
        onTap: (index) {
          // Usamos setState para alterar o estado e reconstruir a tela com o novo índice. [cite: 1390]
          setState(() {
            _currentIndex = index;
          });
        },
        // Lista de itens que aparecerão na barra. [cite: 1364]
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.login),
            label: 'Login', // No exercício, a primeira tela é a de Login/Home
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info_outline),
            label: 'Sobre', // Segunda tela
          ),
        ],
      ),
    );
  }
}

// --- TELA DE LOGIN ---
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _rememberMe = false;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        const SizedBox(height: 20),
        const TextField(
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            labelText: 'E-mail',
          ),
        ),
        const SizedBox(height: 16),
        const TextField(
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'Password',
          ),
        ),
        const SizedBox(height: 16),
        CheckboxListTile(
          title: const Text('Remember me'),
          value: _rememberMe,
          onChanged: (value) {
            setState(() {
              _rememberMe = value!;
            });
          },
          controlAffinity: ListTileControlAffinity.leading,
          contentPadding: EdgeInsets.zero,
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {},
          child: const Text('Enter'),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 12),
          ),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("New here?"),
            // Botão que navega para a tela de Cadastro.
            TextButton(
              child: const Text("Create an account"),
              onPressed: () {
                // Aqui usamos o Navigator para empurrar a nova tela. 
                Navigator.of(context).push(
                  // MaterialPageRoute define a transição e qual tela construir. 
                  MaterialPageRoute(
                    builder: (context) => const RegistrationScreen(),
                  ),
                );
              },
            ),
          ],
        )
      ],
    );
  }
}

// --- TELA DE CADASTRO (CÓDIGO DA ETAPA ANTERIOR) ---
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
      appBar: AppBar(
        title: const Text('Create an account'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          TextField(
            controller: _nameController,
            maxLength: 50,
            keyboardType: TextInputType.name,
            decoration: const InputDecoration(labelText: 'Nome'),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _birthDateController,
            maxLength: 10,
            keyboardType: TextInputType.datetime,
            decoration: const InputDecoration(labelText: 'Data de nascimento', hintText: 'DD/MM/AAAA'),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _phoneController,
            maxLength: 15,
            keyboardType: TextInputType.phone,
            decoration: const InputDecoration(labelText: 'Telefone'),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(labelText: 'E-mail'),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _passwordController,
            maxLength: 20,
            obscureText: _isPasswordObscured,
            decoration: InputDecoration(
              labelText: 'Senha',
              suffixIcon: IconButton(
                icon: Icon(_isPasswordObscured ? Icons.visibility_off : Icons.visibility),
                onPressed: () {
                  setState(() {
                    _isPasswordObscured = !_isPasswordObscured;
                  });
                },
              ),
            ),
          ),
          const SizedBox(height: 24),
          const Text('Gênero:', style: TextStyle(fontSize: 16)),
          Row(
            children: [
              Expanded(
                child: RadioListTile<String>(
                  title: const Text('Masculino'),
                  value: 'masculino',
                  groupValue: _gender,
                  onChanged: (value) => setState(() => _gender = value),
                ),
              ),
              Expanded(
                child: RadioListTile<String>(
                  title: const Text('Feminino'),
                  value: 'feminino',
                  groupValue: _gender,
                  onChanged: (value) => setState(() => _gender = value),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          const Text('Notificações:', style: TextStyle(fontSize: 16)),
          SwitchListTile(
            title: const Text('Receber notificações por E-mail'),
            value: _emailNotifications,
            onChanged: (value) => setState(() => _emailNotifications = value),
          ),
          SwitchListTile(
            title: const Text('Receber notificações por Celular'),
            value: _phoneNotifications,
            onChanged: (value) => setState(() => _phoneNotifications = value),
          ),
          const SizedBox(height: 32),
          ElevatedButton(
            style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 16)),
            onPressed: () {
              // Lógica para salvar os dados
              Navigator.of(context).pop(); // Volta para a tela de login após o cadastro. [cite: 1305]
            },
            child: const Text('Cadastrar'),
          ),
        ],
      ),
    );
  }
}

// --- TELA "SOBRE" (ABOUT) ---
class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Text(
          'Este é um aplicativo de exemplo desenvolvido para praticar os conceitos de navegação em Flutter.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}