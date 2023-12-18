import 'package:bloc_test/bloc_test.dart';
import 'package:buddy/features/dog/domain/entities/dog_breeds_entity.dart';
import 'package:buddy/features/dog/presentation/bloc/dog/remote/remote_dog_bloc.dart';
import 'package:buddy/features/dog/presentation/bloc/dog/remote/remote_dog_event.dart';
import 'package:buddy/features/dog/presentation/bloc/dog/remote/remote_dog_state.dart';
import 'package:buddy/features/dog/presentation/pages/home/dog_breeds_view.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockRemoteDogBloc extends MockBloc<RemoteDogEvent, RemoteDogState>
    implements RemoteDogBloc {}

void main() {
  late MockRemoteDogBloc mockRemoteDogBloc;

  setUp(() {
    mockRemoteDogBloc = MockRemoteDogBloc();
  });

  Widget buildTestableWidget(Widget widget) {
    return BlocProvider<RemoteDogBloc>(
        create: (context) => mockRemoteDogBloc,
        child: MaterialApp(
          home: widget,
        ));
  }

  testWidgets('DogBreedsView displays loading indicator when loading',
      (WidgetTester tester) async {
    when(() => mockRemoteDogBloc.state).thenReturn(RemoteDogLoading());

    await tester.pumpWidget(buildTestableWidget(
      const DogBreedView(),
    ));

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('DogBreedsView displays error message when error occurs',
      (WidgetTester tester) async {
    // arrange
    when(() => mockRemoteDogBloc.state).thenAnswer((_) => RemoteDogError(
        DioException(
            requestOptions: RequestOptions(path: ''), message: 'Error')));

    // act
    await tester.pumpWidget(buildTestableWidget(
      BlocProvider<RemoteDogBloc>(
        create: (context) => mockRemoteDogBloc,
        child: const DogBreedView(),
      ),
    ));

    // assert
    expect(find.text('Error'), findsOneWidget);
  });

  testWidgets('DogBreedsView displays dog breeds when loaded',
      (WidgetTester tester) async {
    final breeds = [
      const DogBreedEntity(
          breedName: 'Labrador',
          breedImage: 'image',
          subBreeds: ['subBreed1', 'subBreed2']),
      const DogBreedEntity(
          breedName: 'Golden Retriever',
          breedImage: 'image',
          subBreeds: ['subBreed1', 'subBreed2'])
    ];
    when(() => mockRemoteDogBloc.state)
        .thenAnswer((_) => RemoteDogLoaded(breeds));

    await tester.pumpWidget(buildTestableWidget(
      BlocProvider<RemoteDogBloc>.value(
        value: mockRemoteDogBloc,
        child: const DogBreedView(),
      ),
    ));

    expect(find.text('Labrador'), findsOneWidget);
    expect(find.text('Golden Retriever'), findsOneWidget);
  });
}
