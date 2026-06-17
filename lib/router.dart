import 'package:app_gerenciamento_motoboys/locator.dart';
import 'package:app_gerenciamento_motoboys/model/motoboy.dart';
import 'package:app_gerenciamento_motoboys/pages/config.dart';
import 'package:app_gerenciamento_motoboys/pages/forms/motoboysForm.dart';
import 'package:app_gerenciamento_motoboys/pages/forms/usersForm.dart';
import 'package:app_gerenciamento_motoboys/pages/gerenciaTeles.dart';
import 'package:app_gerenciamento_motoboys/pages/home.dart';
import 'package:app_gerenciamento_motoboys/pages/login.dart';
import 'package:app_gerenciamento_motoboys/pages/motoboys.dart';
import 'package:app_gerenciamento_motoboys/pages/sobre.dart';
import 'package:flutter/material.dart';

class Routes {
  static const login = "/login";
  static const home = "/home";
  static const usersForm = "/users/form";
  static const motoboys = "/motoboys";
  static const motoboyForm = "/motoboys/form";
  static const teles = "/teles";
  static const config = "/config";
  static const sobre = "/sobre";
}

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Argumentos podem ser passados para as rotas através de `settings.arguments`
    // final args = settings.arguments;

    switch (settings.name) {
      case Routes.login:
        return MaterialPageRoute(builder: (_) => const Login());
      case Routes.home:
        return MaterialPageRoute(builder: (_) => const Home());
      case Routes.usersForm:
        return MaterialPageRoute(builder: (_) => Usersform());
      case Routes.motoboys:
        return MaterialPageRoute(builder: (_) => const Motoboys());
      case Routes.motoboyForm:
         // O formulário pode receber um Motoboy como argumento para edição
        final motoboyToEdit = settings.arguments as Motoboy?;
        return MaterialPageRoute(builder: (_) => Motoboysform(initial: motoboyToEdit));
      case Routes.teles:
        return MaterialPageRoute(builder: (_) => const GerenciamentoTelesPage());
      case Routes.sobre:
        return MaterialPageRoute(builder: (_) => Sobre());
      case Routes.config:
        return MaterialPageRoute(builder: (_) => Config());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('Rota não encontrada: ${settings.name}'),
            ),
          ),
        );
    }
  }
}
