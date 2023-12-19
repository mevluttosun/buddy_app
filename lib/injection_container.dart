import 'package:buddy/config/routes/app_route.dart';
import 'package:buddy/core/app_dio.dart';
import 'package:buddy/features/dog/data/data_sources/remote/dog_api_service_impl.dart';
import 'package:buddy/features/dog/data/data_sources/remote/dog_api_service.dart';
import 'package:buddy/features/dog/data/repository/dog_repository_impl.dart';
import 'package:buddy/features/dog/domain/repository/dog_repository.dart';
import 'package:buddy/features/dog/domain/usecases/get_breeds_usecase.dart';
import 'package:buddy/features/dog/domain/usecases/get_random_image_by_breed_usecase.dart';
import 'package:buddy/features/dog/presentation/bloc/dog/remote/remote_dog_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  // Router
  sl.registerLazySingleton<AppRouter>(() => AppRouter());

  // Dio
  sl.registerLazySingleton<Dio>(() => AppDio());

  // Dependencies
  sl.registerLazySingleton<DogApiService>(() => DogApiServiceImpl(dio: sl()));

  // Repositories
  sl.registerLazySingleton<DogRepository>(() => DogRepositoryImpl(
        dogApiService: sl(),
      ));

  // Use Cases
  sl.registerLazySingleton<GetBreedsUseCase>(
      () => GetBreedsUseCase(repository: sl()));
  sl.registerLazySingleton<GetRandomImageByBreedsUseCase>(
      () => GetRandomImageByBreedsUseCase(repository: sl()));

  // Bloc
  sl.registerFactory<RemoteDogBloc>(() => RemoteDogBloc(sl(), sl()));
}
