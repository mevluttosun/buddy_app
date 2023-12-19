import 'dart:async';
import 'package:buddy/core/constants/asset_paths.dart';
import 'package:buddy/core/resources/data_state.dart';
import 'package:buddy/features/dog/domain/entities/dog_breeds_entity.dart';
import 'package:buddy/features/dog/domain/usecases/get_breeds_usecase.dart';
import 'package:buddy/features/dog/domain/usecases/get_random_image_by_breed_usecase.dart';
import 'package:buddy/features/dog/presentation/bloc/dog/remote/remote_dog_event.dart';
import 'package:buddy/features/dog/presentation/bloc/dog/remote/remote_dog_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RemoteDogBloc extends Bloc<RemoteDogEvent, RemoteDogState> {
  final GetBreedsUseCase _getBreedsUseCase;
  final GetRandomImageByBreedsUseCase _getRandomImageByBreedsUseCase;
  List<DogBreedEntity>? _breeds;
  RemoteDogBloc(this._getBreedsUseCase, this._getRandomImageByBreedsUseCase)
      : super(RemoteDogInitial()) {
    on<RemoteDogFetch>(_getBreeds);
    on<RemoteDogSearch>(_searchBreeds);
  }

  FutureOr<void> _getBreeds(event, Emitter<RemoteDogState> emit) async {
    emit(RemoteDogLoading());
    final datastate = await _getBreedsUseCase();

    if (datastate is DataSuccess && datastate.data!.isNotEmpty) {
      _breeds = datastate.data;
      emit(RemoteDogLoaded(datastate.data!));
    } else if (datastate is DataFailed) {
      emit(RemoteDogError(datastate.error!));
    }
  }

  FutureOr<void> _searchBreeds(
      RemoteDogSearch event, Emitter<RemoteDogState> emit) {
    if (event.query.isEmpty) {
      emit(RemoteDogLoaded(_breeds!));
    } else {
      final datastate = DataSuccess(_breeds?.where((element) {
        return element.breedName!.toLowerCase().contains(event.query);
      }).toList());
      emit(RemoteDogLoaded(datastate.data!));
    }
  }

  Future<String> getDogImageUrlByBreeds(String breedName) async {
    final datastate = await _getRandomImageByBreedsUseCase(params: breedName);
    if (datastate is DataSuccess) {
      return datastate.data!;
    } else {
      return kDefaultImageUrl;
    }
  }
}
