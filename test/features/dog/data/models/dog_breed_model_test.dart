import 'package:buddy/features/dog/data/models/dog_breed_model.dart';
import 'package:buddy/features/dog/domain/entities/dog_breeds_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const dogBreedModel = DogBreedModel(
      breedName: 'affenpinscher',
      breedImage:
          'https://images.dog.ceo/breeds/affenpinscher/n02110627_5743.jpg',
      subBreeds: []);
  test('should be subClass of DogBreedEntity', () async {
    expect(dogBreedModel, isA<DogBreedEntity>());
  });

  test('should return a valid model from json', () async {
    final Map<String, dynamic> jsonMap = {
      "australian": ["kelpie", "shepherd"],
    };
    final result = DogBreedModel.fromMap(jsonMap);
    expect(result, isA<DogBreedModel>());
  });
}
