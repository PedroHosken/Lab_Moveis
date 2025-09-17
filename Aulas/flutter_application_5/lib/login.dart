import 'package:flutter/material.dart';
import 'package:flutter_application_5/reg.dart';

class Login extends StatefulWidget {
  const Login({super.key});
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  // A variável de estado para controlar a aba ativa.
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    // A estrutura do MaterialApp e Scaffold permanece a mesma.
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 58, 183, 93),
        ),
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(
          // O título agora muda conforme a aba selecionada.
          title: Text(_currentIndex == 0 ? 'Login' : 'Minha Conta'),
          backgroundColor: Colors.lightGreen,
        ),
        drawer: const Drawer(),

        // AQUI ESTÁ A MUDANÇA PRINCIPAL
        // O body agora é um IndexedStack.
        body: IndexedStack(
          index: _currentIndex, // Controlado pela variável de estado.
          children: [
            // FILHO 0: O seu formulário de login.
            // (Exatamente o mesmo widget que estava no body antes).
            Center(
              child: Container(
                width: 200,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const TextField(
                      decoration: InputDecoration(labelText: "Nome"),
                      style: TextStyle(color: Colors.purple, fontSize: 15),
                    ),
                    const SizedBox(height: 20),
                    const TextField(
                      decoration: InputDecoration(labelText: "E-mail"),
                      style: TextStyle(color: Colors.purple, fontSize: 15),
                    ),
                    const SizedBox(height: 20),
                    const TextField(
                      decoration: InputDecoration(labelText: "Password"),
                      style: TextStyle(color: Colors.purple, fontSize: 15),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text('Enter'),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          // AQUI ESTÁ A LÓGICA DE NAVEGAÇÃO
                          onPressed: () {
                            // Navigator.of(context) encontra o controlador de navegação. 
                            // .push() "empurra" uma nova rota para a pilha. [cite: 1280]
                            Navigator.of(context).push(
                              // MaterialPageRoute cria a rota com a animação padrão. 
                              MaterialPageRoute(
                                // O builder constrói o widget da nova tela. 
                                builder: (context) => const RegistrationScreen(),
                              ),
                            );
                          },
                          style: TextButton.styleFrom(
                              foregroundColor: Colors.blue),
                          child: const Text('Crie uma conta'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // FILHO 1: O conteúdo da página "Minha Conta".
            const Center(
              child: Text(
                'Aqui ficarão as informações da sua conta.',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),

        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            // A lógica aqui permanece a mesma, atualizando o estado
            // para que o IndexedStack mostre o filho correto.
            setState(() {
              _currentIndex = index;
            });
          },
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Minha Conta',
            ),
          ],
        ),
      ),
    );
  }
}
