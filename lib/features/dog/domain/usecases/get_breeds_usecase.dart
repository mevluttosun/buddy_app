import 'package:buddy/core/resources/data_state.dart';
import 'package:buddy/core/usecases/usecase.dart';
import 'package:buddy/features/dog/domain/entities/dog_breeds_entity.dart';
import 'package:buddy/features/dog/domain/repository/dog_repository.dart';

class GetBreedsUseCase
    implements UseCase<DataState<List<DogBreedEntity>>, void> {
  final DogRepository repository;

  GetBreedsUseCase({required this.repository});

  @override
  Future<DataState<List<DogBreedEntity>>> call({void params}) async {
    return await repository.getDogBreeds();
  }
}
