import 'package:app_gerenciamento_motoboys/locator.dart';
import 'package:app_gerenciamento_motoboys/model/motoboy.dart';
import 'package:app_gerenciamento_motoboys/router.dart';
import 'package:app_gerenciamento_motoboys/services/motoboyService.dart';
import 'package:app_gerenciamento_motoboys/wigdets/cards.dart';
import 'package:app_gerenciamento_motoboys/wigdets/menuDrawer.dart';
import 'package:flutter/material.dart';

class Motoboys extends StatefulWidget {
  const Motoboys({super.key});

  @override
  State<Motoboys> createState() => _MotoboysState();
}

class _MotoboysState extends State<Motoboys> {
  final _service = locator<MotoboyService>();
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

  Future<void> _navigateToForm({Motoboy? motoboy}) async {
    final result = await Navigator.of(context).pushNamed(
      Routes.motoboyForm,
      arguments: motoboy,
    );
    if (result == true) {
      _reload();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Motoboys')),
      drawer: const Menudrawer(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _navigateToForm,
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
              return Center(child: Text('Erro ao carregar: ${snapshot.error}'));
            }
            final users = snapshot.data ?? [];
            if (users.isEmpty) {
              return const Center(child: Text('Nenhum motoboy encontrado'));
            }
            return ListView.builder(
              itemCount: users.length,
              itemBuilder: (_, i) => MotoboyCard(
                nome: users[i].nome,
                onTap: () => _navigateToForm(motoboy: users[i]),
              ),
            );
          },
        ),
      ),
    );
  }
}
