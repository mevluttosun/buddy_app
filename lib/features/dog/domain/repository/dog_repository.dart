import 'package:buddy/core/resources/data_state.dart';
import 'package:buddy/features/dog/domain/entities/dog_breeds_entity.dart';

abstract class DogRepository {
  Future<DataState<String>> getRandomDogImageUrl();
  Future<DataState<List<DogBreedEntity>>> getDogBreeds();
  Future<DataState<String>> getDogImageUrlByBreeds(String breedName);
  Future<DataState<List<String>>> getDogSubBreeds(String breedName);
}
