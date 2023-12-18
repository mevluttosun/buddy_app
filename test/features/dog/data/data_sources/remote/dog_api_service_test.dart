import 'dart:convert';

import 'package:buddy/features/dog/data/data_sources/remote/dog_api_service_impl.dart';
import 'package:buddy/features/dog/data/models/dog_breed_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:buddy/features/dog/data/data_sources/remote/dog_api_service.dart';
import 'package:mockito/mockito.dart';

import '../../../../../helpers/json_reader.dart';
import '../../../../../helpers/test_helper.mocks.dart';

void main() {
  group('DogApiService', () {
    late DogApiService dogApiService;
    late MockAppDio mockAppDio;
    setUp(() {
      mockAppDio = MockAppDio();
      dogApiService = DogApiServiceImpl(dio: mockAppDio);
    });

    test('getRandomDogImage should return a valid URL', () async {
      when(mockAppDio.get(any)).thenAnswer((_) async => Response(
          requestOptions: RequestOptions(path: ''),
          data: {
            'message':
                'https://images.dog.ceo/breeds/terrier-norwich/n02094258_100.jpg'
          },
          statusCode: 200));

      final url = await dogApiService.getRandomDogImage();
      expect(url, isA<String>());
      expect(url, startsWith('http'));
    });

    test('getDogBreedList should return a list of DogBreedModel', () async {
      when(mockAppDio.get(any)).thenAnswer((_) async => Response(
          requestOptions: RequestOptions(path: ''),
          data: json.decode(
            readJson('helpers/dummy_data/dummy_breeds_response.json'),
          ),
          statusCode: 200));

      final breedList = await dogApiService.getDogBreedList();
      expect(breedList, isA<List<DogBreedModel>>());
    });

    test('getDogImageUrlByBreeds should return a valid URL', () async {
      when(mockAppDio.get(any)).thenAnswer((_) async => Response(
          requestOptions: RequestOptions(path: ''),
          data: {
            'message':
                'https://images.dog.ceo/breeds/terrier-norwich/n02094258_100.jpg'
          },
          statusCode: 200));
      const breedName = 'Labrador';
      final url = await dogApiService.getDogImageUrlByBreeds(breedName);
      expect(url, isA<String>());
      expect(url, startsWith('http'));
    });

    test('getDogSubBreeds should return a list of sub-breeds', () async {
      when(mockAppDio.get(any)).thenAnswer((_) async => Response(
          requestOptions: RequestOptions(path: ''),
          data: {
            'message': ['shepherd'],
            "status": "success"
          },
          statusCode: 200));
      const breedName = 'Labrador';
      final subBreeds = await dogApiService.getDogSubBreeds(breedName);
      expect(subBreeds, isA<List<String>>());
    });
  });
}
