import 'package:app_gerenciamento_motoboys/locator.dart';
import 'package:app_gerenciamento_motoboys/provider/userProvider.dart';
import 'package:app_gerenciamento_motoboys/router.dart';
import 'package:app_gerenciamento_motoboys/services/temaService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  // Garante que o Flutter está inicializado
  WidgetsFlutterBinding.ensureInitialized();

  // Carrega as variáveis de ambiente
  await dotenv.load(fileName: ".env");

  // Configura o Service Locator (registra os serviços)
  setupLocator();

  // Inicia a aplicação
  runApp(
    ChangeNotifierProvider(
      create: (context) => Userprovider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Obtém a instância do TemaService através do locator
    final temaService = locator<TemaService>();

    return ValueListenableBuilder<ThemeMode>(
      valueListenable: temaService.temaNotifier,
      builder: (context, currentMode, child) {
        return MaterialApp(
          title: 'Meu app',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(colorSchemeSeed: Colors.blue, useMaterial3: true),
          darkTheme: ThemeData(
            primarySwatch: Colors.indigo,
            brightness: Brightness.dark,
            useMaterial3: true,
          ),
          themeMode: currentMode,
          initialRoute: Routes.login,
          // Usa o AppRouter para gerar todas as rotas
          onGenerateRoute: AppRouter.generateRoute,
        );
      },
    );
  }
}
