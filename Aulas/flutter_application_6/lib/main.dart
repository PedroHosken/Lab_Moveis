import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'One Piece Character Finder',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        useMaterial3: true,
      ),
      home: const BuscaPersonagemPage(),
    );
  }
}

// MODELO ATUALIZADO
class Personagem {
  final String name;
  final String bounty;
  final String age; // NOVO
  final String job; // NOVO
  final Crew crew;
  final Fruit? fruit;

  Personagem({
    required this.name,
    required this.bounty,
    required this.age, // NOVO
    required this.job, // NOVO
    required this.crew,
    this.fruit,
  });

  factory Personagem.fromJson(Map<String, dynamic> json) {
    return Personagem(
      name: json['name'] ?? 'Nome Desconhecido',
      bounty: json['bounty'] ?? 'Recompensa Desconhecida',
      age: json['age'] ?? 'Idade Desconhecida', // NOVO
      job: json['job'] ?? 'Função Desconhecida', // NOVO
      crew: Crew.fromJson(json['crew'] ?? {'name': 'Sem Tripulação'}),
      fruit: json['fruit'] != null ? Fruit.fromJson(json['fruit']) : null,
    );
  }
}

class Crew {
  final String name;
  Crew({required this.name});
  factory Crew.fromJson(Map<String, dynamic> json) {
    return Crew(name: json['name'] ?? 'Tripulação Desconhecida');
  }
}

class Fruit {
  final String name;
  final String type;
  Fruit({required this.name, required this.type});
  factory Fruit.fromJson(Map<String, dynamic> json) {
    return Fruit(
      name: json['name'] ?? 'Nome Desconhecido',
      type: json['type'] ?? 'Tipo Desconhecido',
    );
  }
}

Future<Personagem> fetchPersonagemPorId(String id) async {
  final response = await http.get(
    Uri.parse('https://api.api-onepiece.com/v2/characters/en/$id'),
  );

  if (response.statusCode == 200) {
    return Personagem.fromJson(jsonDecode(response.body));
  } else if (response.statusCode == 404) {
    throw Exception('Personagem não encontrado com o ID: $id');
  } else {
    throw Exception('Falha ao carregar o personagem.');
  }
}

class BuscaPersonagemPage extends StatefulWidget {
  const BuscaPersonagemPage({super.key});

  @override
  State<BuscaPersonagemPage> createState() => _BuscaPersonagemPageState();
}

class _BuscaPersonagemPageState extends State<BuscaPersonagemPage> {
  final TextEditingController _idController = TextEditingController();
  Personagem? _personagem;
  bool _isLoading = false;
  String? _errorMessage;

  void _buscarPersonagem() async {
    final id = _idController.text;
    if (id.isEmpty) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
      _personagem = null;
    });

    try {
      final personagemEncontrado = await fetchPersonagemPorId(id);
      setState(() {
        _personagem = personagemEncontrado;
      });
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buscar Personagem por ID'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _idController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Digite o ID do Personagem',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: _isLoading ? null : _buscarPersonagem,
              child: const Text('Buscar'),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                // Adicionado para evitar overflow se o card for grande
                child: Center(child: _buildResultado()),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // NOVO WIDGET DE RESULTADO
  Widget _buildResultado() {
    if (_isLoading) {
      return const CircularProgressIndicator();
    } else if (_errorMessage != null) {
      return Text(
        _errorMessage!,
        style: const TextStyle(color: Colors.red, fontSize: 16),
        textAlign: TextAlign.center,
      );
    } else if (_personagem != null) {
      final personagem = _personagem!;
      return Card(
        elevation: 4.0,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                personagem.name,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                personagem.job,
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(color: Colors.grey[700]),
              ),
              const SizedBox(height: 8),
              const Divider(),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildInfoColumn('Idade', personagem.age),
                  _buildInfoColumn('Recompensa', personagem.bounty),
                ],
              ),
              const SizedBox(height: 8),
              const Divider(),
              const SizedBox(height: 8),
              _buildInfoRow(Icons.group, 'Tripulação', personagem.crew.name),
              const SizedBox(height: 8),
              _buildInfoRow(
                Icons.restaurant,
                'Akuma no Mi',
                personagem.fruit != null
                    ? '${personagem.fruit!.name} (${personagem.fruit!.type})'
                    : 'Nenhuma',
              ),
            ],
          ),
        ),
      );
    } else {
      return const Text(
        'Digite um ID e pressione "Buscar". Ex: 1 (Luffy), 2 (Zoro)',
      );
    }
  }

  // WIDGETS AUXILIARES
  Widget _buildInfoColumn(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(color: Colors.grey, fontSize: 12)),
        Text(value, style: Theme.of(context).textTheme.titleMedium),
      ],
    );
  }

  Widget _buildInfoRow(IconData icon, String title, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: Theme.of(context).primaryColor, size: 20),
        const SizedBox(width: 8),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
              Text(value),
            ],
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _idController.dispose();
    super.dispose();
  }
}
