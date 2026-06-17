import 'package:app_gerenciamento_motoboys/locator.dart';
import 'package:app_gerenciamento_motoboys/provider/userProvider.dart';
import 'package:app_gerenciamento_motoboys/router.dart';
import 'package:app_gerenciamento_motoboys/services/temaService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  setupLocator(); // Configura o Service Locator

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
          onGenerateRoute: AppRouter.generateRoute, // Usa o roteador centralizado
        );
      },
    );
  }
}
