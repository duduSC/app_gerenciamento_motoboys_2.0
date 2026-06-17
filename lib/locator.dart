import 'package:app_gerenciamento_motoboys/services/motoboyService.dart';
import 'package:app_gerenciamento_motoboys/services/temaService.dart';
import 'package:app_gerenciamento_motoboys/services/userService.dart';
import 'package:get_it/get_it.dart';

// Instância global do Service Locator
final GetIt locator = GetIt.instance;

/// Registra todos os serviços (singletons) para que possam ser acessados
/// de qualquer lugar do app através do `locator`.
void setupLocator() {
  // O TemaService é registrado como um singleton. A mesma instância será
  // retornada toda vez que `locator<TemaService>()` for chamado.
  locator.registerLazySingleton<TemaService>(() => TemaService());

  // O UserService também é um singleton.
  locator.registerLazySingleton<UserService>(() => UserService());

  // O MotoboyService também é um singleton.
  locator.registerLazySingleton<MotoboyService>(() => MotoboyService());
}
