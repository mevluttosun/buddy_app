import 'package:equatable/equatable.dart';

class DogBreedEntity extends Equatable {
  final String? breedName;
  final String? breedImage;
  final List<String?>? subBreeds;

  const DogBreedEntity({
    required this.breedName,
    required this.breedImage,
    required this.subBreeds,
  });

  @override
  List<Object?> get props => [breedName, breedImage, subBreeds];
}
