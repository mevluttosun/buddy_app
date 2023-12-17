import 'package:buddy/features/dog/domain/entities/dog_breeds_entity.dart';

class DogBreedModel extends DogBreedEntity {
  const DogBreedModel({
    required String? breedName,
    required String? breedImage,
    required List<String?>? subBreeds,
  }) : super(
          breedName: breedName,
          breedImage: breedImage,
          subBreeds: subBreeds,
        );

  factory DogBreedModel.fromJson(Map<String, dynamic> json) {
    print(json['subBreeds']);
    print(json['subBreeds'].runtimeType);
    return DogBreedModel(
      breedName: json['name'],
      breedImage: json['image'],
      subBreeds: json['subBreeds'],
    );
  }

  factory DogBreedModel.fromMap(Map<String, dynamic> map) {
    final subBreeds = List<String>.from(map.values.first as List<dynamic>);
    return DogBreedModel(
      breedName: map.keys.first,
      breedImage: '',
      subBreeds: subBreeds,
    );
  }

  factory DogBreedModel.fromEntity(DogBreedEntity entity) {
    return DogBreedModel(
      breedName: entity.breedName,
      breedImage: entity.breedImage,
      subBreeds: entity.subBreeds,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': breedName,
      'image': {'url': breedImage},
      'subBreeds': subBreeds,
    };
  }
}
