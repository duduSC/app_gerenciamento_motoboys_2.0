import 'package:flutter/material.dart';

class CardNavegacao extends StatelessWidget {
  final IconData icone;
  final String titulo;
  final String paginaDestino;

  const CardNavegacao({
    super.key,
    required this.icone,
    required this.titulo,
    required this.paginaDestino,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, paginaDestino);
      },
      child: Card(
        elevation: 5,
        child: SizedBox(
          width: 150,
          height: 150,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icone, size: 60, color: Theme.of(context).primaryColor),
              const SizedBox(height: 10),
              Text(
                titulo,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MotoboyCard extends StatelessWidget {
  final String nome;
  final VoidCallback onTap;

  const MotoboyCard({
    super.key,
    required this.nome,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: ListTile(
                  title: Text(
                    nome,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              const Icon(Icons.arrow_forward),
            ],
          ),
        ),
      ),
    );
  }
}
