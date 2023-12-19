import 'package:buddy/core/resources/data_state.dart';
import 'package:buddy/features/dog/data/models/dog_breed_model.dart';
import 'package:buddy/features/dog/data/repository/dog_repository_impl.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../helpers/dummy_data/dog_breeds_list.dart';
import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late DogRepositoryImpl dogRepositoryImpl;
  late MockDogApiService mockDogApiService;

  setUp(() {
    mockDogApiService = MockDogApiService();
    dogRepositoryImpl = DogRepositoryImpl(dogApiService: mockDogApiService);
  });

  group('get dog breeds', () {
    test('should return a list of DogBreedEntity succesfully', () async {
      // arrange
      when(mockDogApiService.getDogBreedList())
          .thenAnswer((_) async => dogBreeds);

      when(mockDogApiService.getDogImageUrlByBreeds(any))
          .thenAnswer((_) async => 'breedImage');

      // act
      final result = await dogRepositoryImpl.getDogBreeds();
      // assert
      expect(result, DataSuccess(dogBreeds));
    });

    test('should return a DataFailed when an exception occurs', () async {
      // arrange
      when(mockDogApiService.getDogBreedList())
          .thenThrow(DioException(requestOptions: RequestOptions(path: '')));
      // act
      final result = await dogRepositoryImpl.getDogBreeds();
      // assert
      expect(result, isA<DataFailed>());
    });

    //TODO: add socket exception test
  });
}
