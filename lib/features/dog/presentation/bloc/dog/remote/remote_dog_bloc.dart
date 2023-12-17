import 'dart:async';

import 'package:buddy/core/resources/data_state.dart';
import 'package:buddy/features/dog/domain/repository/dog_repository.dart';
import 'package:buddy/features/dog/domain/usecases/get_breeds_usecase.dart';
import 'package:buddy/features/dog/presentation/bloc/dog/remote/remote_dog_event.dart';
import 'package:buddy/features/dog/presentation/bloc/dog/remote/remote_dog_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RemoteDogBloc extends Bloc<RemoteDogEvent, RemoteDogState> {
  final GetBreedsUseCase _getBreedsUseCase;

  RemoteDogBloc(this._getBreedsUseCase) : super(RemoteDogInitial()) {
    on<RemoteDogFetch>(_getBreeds);
  }

  FutureOr<void> _getBreeds(event, Emitter<RemoteDogState> emit) async {
    emit(RemoteDogLoading());
    final datastate = await _getBreedsUseCase();

    if (datastate is DataSuccess && datastate.data!.isNotEmpty) {
      emit(RemoteDogLoaded(datastate.data!));
    } else if (datastate is DataFailed) {
      emit(RemoteDogError(datastate.error!));
    }
  }
}
