import 'package:buddy/features/dog/data/models/dog_breed_model.dart';

abstract class DogApiService {
  DogApiService();

  Future<String> getRandomDogImage();

  Future<List<DogBreedModel>> getDogBreedList();

  Future<String> getDogImageUrlByBreeds(String breedName);

  Future<List<String>> getDogSubBreeds(String breedName);
}
