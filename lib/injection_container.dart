import 'package:buddy/config/routes/app_route.dart';
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  // Router
  sl.registerLazySingleton<AppRouter>(() => AppRouter());

  // Dio
  sl.registerLazySingleton<Dio>(() => Dio());
}
