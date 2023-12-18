import 'package:bloc_test/bloc_test.dart';
import 'package:buddy/core/resources/data_state.dart';
import 'package:buddy/features/dog/presentation/bloc/dog/remote/remote_dog_bloc.dart';
import 'package:buddy/features/dog/presentation/bloc/dog/remote/remote_dog_event.dart';
import 'package:buddy/features/dog/presentation/bloc/dog/remote/remote_dog_state.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../../../helpers/dummy_data/dog_breeds_list.dart';
import '../../../../../../helpers/test_helper.mocks.dart';

void main() {
  late MockGetBreedsUseCase mockGetBreedsUseCase;
  late RemoteDogBloc remoteDogBloc;
  setUp(() {
    mockGetBreedsUseCase = MockGetBreedsUseCase();
    remoteDogBloc = RemoteDogBloc(mockGetBreedsUseCase);
  });

  group('RemoteDogBloc', () {
    test('initial state should be Empty', () async {
      expect(remoteDogBloc.state, RemoteDogInitial());
    });

    test('should get data from the usecase', () async {
      // arrange
      when(mockGetBreedsUseCase())
          .thenAnswer((_) async => DataSuccess(dogBreeds));
      // act
      remoteDogBloc.add(RemoteDogFetch());
      await untilCalled(mockGetBreedsUseCase());
      // assert
      verify(mockGetBreedsUseCase());
    });

    blocTest<RemoteDogBloc, RemoteDogState>(
        'should emit [RemoteDogLoading, RemoteDogLoaded] when data is gotten successfully',
        build: () {
          when(mockGetBreedsUseCase())
              .thenAnswer((_) async => DataSuccess(dogBreeds));
          return remoteDogBloc;
        },
        act: (bloc) => bloc.add(RemoteDogFetch()),
        expect: () => [RemoteDogLoading(), RemoteDogLoaded(dogBreeds)]);

    var badResponseDioError = DioException(
      requestOptions: RequestOptions(path: ''),
      response: Response(
        statusCode: 400,
        requestOptions: RequestOptions(path: ''),
      ),
    );
    blocTest<RemoteDogBloc, RemoteDogState>(
        'should emit [RemoteDogLoading, RemoteDogError] when getting data fails',
        build: () {
          when(mockGetBreedsUseCase())
              .thenAnswer((_) async => DataFailed(badResponseDioError));
          return remoteDogBloc;
        },
        act: (bloc) => bloc.add(RemoteDogFetch()),
        expect: () =>
            [RemoteDogLoading(), RemoteDogError(badResponseDioError)]);
  });
}
