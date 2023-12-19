import 'package:buddy/core/resources/data_state.dart';
import 'package:buddy/core/usecases/usecase.dart';
import 'package:buddy/features/dog/domain/repository/dog_repository.dart';

class GetRandomImageByBreedsUseCase
    implements UseCase<DataState<String>, String> {
  final DogRepository repository;

  GetRandomImageByBreedsUseCase({required this.repository});

  @override
  Future<DataState<String>> call({String? params}) async {
    return await repository.getDogImageUrlByBreeds(params!);
  }
}
