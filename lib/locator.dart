import 'package:app_gerenciamento_motoboys/services/motoboyService.dart';
import 'package:app_gerenciamento_motoboys/services/temaService.dart';
import 'package:app_gerenciamento_motoboys/services/userService.dart';
import 'package:get_it/get_it.dart';

// Instância global do Service Locator
final GetIt locator = GetIt.instance;

/// Registra todos os serviços (singletons) para que possam ser acessados
/// de qualquer lugar do app através do `locator`.
void setupLocator() {
  locator.registerLazySingleton<TemaService>(() => TemaService());
  locator.registerLazySingleton<UserService>(() => UserService());
  locator.registerLazySingleton<MotoboyService>(() => MotoboyService());
}
