import 'package:app_gerenciamento_motoboys/locator.dart';
import 'package:app_gerenciamento_motoboys/model/motoboy.dart';
import 'package:app_gerenciamento_motoboys/pages/forms/motoboysForm.dart';
import 'package:app_gerenciamento_motoboys/services/motoboyService.dart';
import 'package:app_gerenciamento_motoboys/wigdets/cards.dart';
import 'package:app_gerenciamento_motoboys/wigdets/menuDrawer.dart';
import 'package:flutter/material.dart';

class Motoboys extends StatefulWidget {
  // O serviço agora será obtido via Service Locator, não mais pelo construtor.
  const Motoboys({super.key});

  @override
  State<Motoboys> createState() => _MotoboysState();
}

class _MotoboysState extends State<Motoboys> {
  // O serviço é obtido do locator.
  final MotoboyService _service = locator<MotoboyService>();
  late Future<List<Motoboy>> _future;

  @override
  void initState() {
    super.initState();
    _reload();
  }

  void _reload() {
    setState(() {
      _future = _service.getMotoboys();
    });
  }

  /// Navega para o formulário de motoboy, seja para criar um novo (initial == null)
  /// ou para editar um existente. Após o retorno, recarrega a lista se houver mudanças.
  Future<void> _navigateToForm({Motoboy? initial}) async {
    final changed = await Navigator.of(context).push<bool>(
      MaterialPageRoute(
        builder: (_) => Motoboysform(initial: initial),
      ),
    );
    if (changed == true) {
      _reload();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Motoboys')),
      drawer: const Menudrawer(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _navigateToForm(), // Chama o método unificado
        icon: const Icon(Icons.person_add_alt_1),
        label: const Text('Novo'),
      ),
      body: RefreshIndicator(
        onRefresh: () async => _reload(),
        child: FutureBuilder<List<Motoboy>>(
          future: _future,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return ListView(
                children: [
                  const SizedBox(height: 120),
                  Center(
                    child: Column(
                      children: [
                        const Icon(Icons.error_outline, size: 48),
                        const SizedBox(height: 8),
                        Text('Erro ao carregar: ${snapshot.error}'),
                        const SizedBox(height: 8),
                        FilledButton.icon(
                          onPressed: _reload,
                          icon: const Icon(Icons.refresh),
                          label: const Text('Tentar novamente'),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }
            final users = snapshot.data ?? [];
            if (users.isEmpty) {
              return ListView(
                children: const [
                  SizedBox(height: 120),
                  Center(child: Text('Nenhum motoboy encontrado')),
                ],
              );
            }
            return ListView.builder(
              itemCount: users.length,
              // Usa o novo widget MotoboyCard
              itemBuilder: (_, i) => MotoboyCard(
                nome: users[i].nome,
                onTap: () => _navigateToForm(initial: users[i]),
              ),
            );
          },
        ),
      ),
    );
  }
}
