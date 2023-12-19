import 'package:buddy/core/app_dio.dart';
import 'package:buddy/features/dog/data/data_sources/remote/dog_api_service.dart';
import 'package:buddy/features/dog/domain/repository/dog_repository.dart';
import 'package:buddy/features/dog/domain/usecases/get_breeds_usecase.dart';
import 'package:buddy/features/dog/domain/usecases/get_random_image_by_breed_usecase.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks(
  [
    AppDio,
    DogRepository,
    DogApiService,
    GetBreedsUseCase,
    GetRandomImageByBreedsUseCase
  ],
)
void main() {}
