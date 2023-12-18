import 'package:buddy/core/resources/data_state.dart';
import 'package:buddy/features/dog/domain/entities/dog_breeds_entity.dart';
import 'package:buddy/features/dog/domain/usecases/get_breeds_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late GetBreedsUseCase useCase;
  late MockDogRepository mockDogRepository;

  setUp(() {
    mockDogRepository = MockDogRepository();
    useCase = GetBreedsUseCase(repository: mockDogRepository);
  });
  DogBreedEntity tDogBreedEntity = const DogBreedEntity(
    breedName: 'breedName',
    subBreeds: ['subBreed1', 'subBreed2'],
    breedImage: 'breedImage',
  );

  test('should get dog breeds from repository', () async {
    // arrange
    when(mockDogRepository.getDogBreeds())
        .thenAnswer((_) async => DataSuccess([tDogBreedEntity]));
    // act
    final result = await useCase();
    // assert
    expect(result, DataSuccess([tDogBreedEntity]));
  });
}
