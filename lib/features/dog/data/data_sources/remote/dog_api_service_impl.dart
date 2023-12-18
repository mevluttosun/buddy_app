import 'package:buddy/features/dog/data/data_sources/remote/dog_api_service.dart';
import 'package:buddy/features/dog/data/models/dog_breed_model.dart';
import 'package:dio/dio.dart';

class DogApiServiceImpl implements DogApiService {
  final Dio dio;

  DogApiServiceImpl({required this.dio});

  @override
  Future<String> getRandomDogImage() async {
    final response = await dio.get('/breeds/image/random');
    final data = response.data as Map<String, dynamic>;
    final message = data['message'] as String;
    return message;
  }

  @override
  Future<List<DogBreedModel>> getDogBreedList() async {
    final response = await dio.get('/breeds/list/all');
    final data = response.data as Map<String, dynamic>;
    final breedsMap = data['message'] as Map<String, dynamic>;
    final dogBreeds = <DogBreedModel>[];
    for (final entry in breedsMap.entries) {
      final breed = DogBreedModel.fromMap({
        entry.key: entry.value,
      });
      dogBreeds.add(breed);
    }
    return dogBreeds;
  }

  @override
  Future<String> getDogImageUrlByBreeds(String breedName) async {
    final response = await dio.get('/breed/$breedName/images/random');
    final data = response.data as Map<String, dynamic>;
    final message = data['message'] as String;
    return message;
  }

  @override
  Future<List<String>> getDogSubBreeds(String breedName) async {
    final response = await dio.get('/breed/$breedName/list');
    final data = response.data as Map<String, dynamic>;
    final message = data['message'] as List<dynamic>;
    return message.map((e) => e.toString()).toList();
  }
}
