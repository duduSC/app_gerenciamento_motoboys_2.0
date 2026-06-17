import 'package:app_gerenciamento_motoboys/locator.dart';
import 'package:app_gerenciamento_motoboys/pages/config.dart';
import 'package:app_gerenciamento_motoboys/pages/forms/motoboysForm.dart';
import 'package:app_gerenciamento_motoboys/pages/forms/usersForm.dart';
import 'package:app_gerenciamento_motoboys/pages/gerenciaTeles.dart';
import 'package:app_gerenciamento_motoboys/pages/home.dart';
import 'package:app_gerenciamento_motoboys/pages/login.dart';
import 'package:app_gerenciamento_motoboys/pages/motoboys.dart';
import 'package:app_gerenciamento_motoboys/pages/sobre.dart';
import 'package:app_gerenciamento_motoboys/services/motoboyService.dart';
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
    switch (settings.name) {
      case Routes.login:
        return MaterialPageRoute(
          settings: const RouteSettings(name: Routes.login),
          builder: (_) => const Login(),
        );
      case Routes.home:
        return MaterialPageRoute(
          settings: const RouteSettings(name: Routes.home),
          builder: (_) => const Home(),
        );
      case Routes.usersForm:
        return MaterialPageRoute(
          settings: const RouteSettings(name: Routes.usersForm),
          // O formulário agora obtém o serviço via locator
          builder: (_) => Usersform(),
        );
      case Routes.motoboys:
        return MaterialPageRoute(
          settings: const RouteSettings(name: Routes.motoboys),
           // A página agora obtém o serviço via locator
          builder: (_) => const Motoboys(),
        );
      case Routes.motoboyForm:
        return MaterialPageRoute(
          settings: const RouteSettings(name: Routes.motoboyForm),
           // O formulário agora obtém o serviço via locator
          builder: (_) => Motoboysform(),
        );
      case Routes.teles:
        return MaterialPageRoute(
          settings: const RouteSettings(name: Routes.teles),
          // A página agora obtém o serviço via locator
          builder: (_) => GerenciamentoTelesPage(service: locator<MotoboyService>()),
        );
      case Routes.sobre:
        return MaterialPageRoute(
          settings: const RouteSettings(name: Routes.sobre),
          builder: (_) => Sobre(),
        );
      case Routes.config:
        return MaterialPageRoute(
          settings: const RouteSettings(name: Routes.config),
          builder: (_) => Config(),
        );
      default:
        // Rota padrão em caso de erro ou rota não encontrada
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
