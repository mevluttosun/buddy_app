import 'dart:io';

import 'package:buddy/core/resources/data_state.dart';
import 'package:buddy/features/dog/data/data_sources/remote/dog_api_service_impl.dart';
import 'package:buddy/features/dog/data/data_sources/remote/dog_api_service.dart';
import 'package:buddy/features/dog/data/models/dog_breed_model.dart';
import 'package:buddy/features/dog/domain/repository/dog_repository.dart';
import 'package:dio/dio.dart';

class DogRepositoryImpl extends DogRepository {
  final DogApiService dogApiService;

  DogRepositoryImpl({required this.dogApiService});

  @override
  Future<DataState<String>> getRandomDogImageUrl() async {
    try {
      final response = await dogApiService.getRandomDogImage();
      return DataSuccess(response);
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<List<DogBreedModel>>> getDogBreeds() async {
    final futureImageList = <Future<String>>[];
    try {
      final response = await dogApiService.getDogBreedList();
      for (var breed in response) {
        futureImageList
            .add(dogApiService.getDogImageUrlByBreeds(breed.breedName!));
      }
      var dogBreedsWithImages = <DogBreedModel>[];
      var images = await Future.wait(futureImageList);
      for (int i = 0; i < response.length; i++) {
        var breed = response[i];
        dogBreedsWithImages.add(DogBreedModel(
          breedName: breed.breedName,
          breedImage: images[i],
          subBreeds: breed.subBreeds,
        ));
      }
      return DataSuccess(dogBreedsWithImages);
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<String>> getDogImageUrlByBreeds(String breedName) async {
    try {
      final response = await dogApiService.getDogImageUrlByBreeds(breedName);
      return DataSuccess(response);
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<List<String>>> getDogSubBreeds(String breedName) async {
    try {
      final response = await dogApiService.getDogSubBreeds(breedName);
      return DataSuccess(response);
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }
}
