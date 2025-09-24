import 'package:flutter/material.dart';

class ItemListPage extends StatelessWidget {
  // A tela agora recebe e armazena o nome do usuário.
  final String name;

  // O construtor foi atualizado para requerer o nome.
  const ItemListPage({super.key, required this.name});

  void _showItemDialog(BuildContext context, int itemIndex) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Alerta'),
          content: Text('Você clicou no item ${itemIndex + 1}'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Não'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Sim'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // O título da AppBar agora é dinâmico e usa o nome recebido.
        title: Text('Bem vindo(a), $name'),
      ),
      body: Center(
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: 20,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              leading: const Icon(Icons.check_circle_outline),
              title: Text('Item número ${index + 1}'),
              onTap: () {
                _showItemDialog(context, index);
              },
            );
          },
        ),
      ),
    );
  }
}